require 'darkext/hash'

class String
  # Parses a string like "1..10" to a Range
  def to_range
    case self.count('.')
    when 2
      elements = self.split('..')
      return Range.new(elements[0].to_i, elements[1].to_i)
    when 3
      elements = self.split('...')
      return Range.new(elements[0].to_i, elements[1].to_i-1)
    end
    return nil
  end

  # Executes the string with system
  def exec(opts = {})
    opts.with_defaults!(:background => false)
    cmd = self
    cmd += " &" if opts[:background]
    system(cmd)
  end

  alias :/ :split
end
