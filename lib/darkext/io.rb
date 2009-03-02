require 'darkext/hash'

module DarkIO
  # Runs a block and captures the output it generates
  def self.capture_output(opts = { }) # yield e
    opts.with_defaults!(:stdout => true, :stderr => false)
    cout,cerr = opts[:stdout],opts[:stderr]

    yield and return if !cout && !cerr

    old_stdout = STDOUT.dup if cout
    old_stderr = STDERR.dup if cerr

    r_stdout,w_stdout = IO.pipe if cout
    r_stderr,w_stderr = IO.pipe if cerr

    STDOUT.reopen(w_stdout) if cout
    STDERR.reopen(w_stderr) if cerr

    begin
      yield
    ensure
      STDOUT.reopen(old_stdout) if cout
      STDERR.reopen(old_stderr) if cerr
      w_stdout.close if cout
      w_stderr.close if cerr
    end

    ret_stdout = r_stdout.read if cout
    ret_stderr = r_stderr.read if cerr
    r_stdout.close if cout
    r_stderr.close if cerr
    return ret_stdout,ret_stderr if cout && cerr
    return ret_stdout if cout
    return ret_stderr if cerr
  end
end
