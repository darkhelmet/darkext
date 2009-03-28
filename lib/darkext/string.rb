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
    return `#{self}` if opts[:capture]
    return fork { system(self) } if opts[:background]
    return system(self)
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

  def starts_with?(str)
    str = str.to_s
    str == self[0, str.length]
  end

  def ends_with?(str)
    str = str.to_s
    str == self[-str.length, str.length]
  end

  alias :/ :split
end
