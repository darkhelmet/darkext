require 'rbconfig'

class SinatraAppGenerator < RubiGen::Base
  DEFAULT_SHEBANG = File.join(Config::CONFIG['bindir'],
                              Config::CONFIG['ruby_install_name'])

  default_options(:shebang => DEFAULT_SHEBANG)

  attr_accessor :app_name, :module_name

  def initialize(runtime_args, runtime_options = {})
    super
    usage if args.empty?
    @destination_root = args.shift
    self.app_name = File.basename(File.expand_path(@destination_root))
    self.module_name = app_name.camelize
  end

  def manifest
    # Use /usr/bin/env if no special shebang was specified
    script_options = { :chmod => 0755, :shebang => options[:shebang] == DEFAULT_SHEBANG ? nil : options[:shebang] }
    windows = (RUBY_PLATFORM =~ /dos|win32|cygwin/i) || (RUBY_PLATFORM =~ /(:?mswin|mingw)/)

    record do |m|
      # Root directory and all subdirectories.
      m.directory('')
      %w(lib public views).each { |path| m.directory(path) }
      %w(get put post delete).each do |path|
        m.directory("lib/#{path}")
        m.template('http_method.rb', "lib/#{path}.rb", :assigns => { :method => path })
      end
      m.template('helpers.rb', "lib/helpers.rb")
      m.template('app.rb', "#{app_name}.rb")
      #m.dependency "install_rubigen_scripts", [destination_root, "rubygems"], :shebang => options[:shebang]
    end
  end

  protected
  def banner
    "Create a stub for #{File.basename $0} to get started."
  end

  def add_options!(opts)
    opts.separator ''
    opts.separator 'Options:'
    opts.on("-r", "--ruby=path", String,
            "Path to the Ruby binary of your choice (otherwise scripts use env, dispatchers current path).",
            "Default: #{DEFAULT_SHEBANG}") { |v| options[:shebang] = v }
  end
end
