require 'mathn'

class Numeric
  # Squares the number
  def square
    self * self
  end

  # Cube the number
  def cube
    self.square * self
  end

  # Finds the square root of the number
  def sqrt
    Math.sqrt(self)
  end

  # Do some other roots
  def root(n = 2)
    return self if 1 == n
    return self.sqrt if 2 == n
    self ** (1 / n.to_f)
  end

  # Finds the log base e of the number
  def ln
    Math::log(self)
  end

  # Finds the log base 10 of the number
  def log
    Math::log10(self)
  end
end
