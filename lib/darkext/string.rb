require 'darkext/hash'

class String
  # Parses a string like "1..10" to a Range
  def to_range
    case self.count('.')
    when 2
      elements = self.split('..')
      if elements[0] == elements[0].to_i.to_s
        return Range.new(elements[0].to_i, elements[1].to_i)
      else
        return Range.new(elements[0], elements[1])
      end
    when 3
      elements = self.split('...')
      if elements[0] == elements[0].to_i.to_s
        return Range.new(elements[0].to_i, (elements[1] - 1).to_i)
      else
        return Range.new(elements[0], elements[1] - 1)
      end
    end
    return nil
  end

  # Executes the string with system
  # * :background => true to run command in the background using & (currently only works on *nix systems)
  # * :capture => true to capture the output. If :capture => true, background is voided
  def exec(opts = {})
    opts.with_defaults!(:background => false, :capture => false)
    cmd = self
    # TODO: Do this with threads maybe, so it's OS agnostic?
    cmd += " &" if opts[:background] && !opts[:capture]
    return system(cmd) if !opts[:capture]
    return `#{cmd}` if opts[:capture]
  end

  # Prints the String using print
  def print
    Kernel.print(self)
  end

  def printn
    Kernel.print(self + "\n")
  end

  def true?
    self.downcase == 'true'
  end

  def false?
    self.downcase == 'false'
  end

  alias :/ :split
end
