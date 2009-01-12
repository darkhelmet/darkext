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
    return self.sqrt if n == 2
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

class Float
  EPISILON = 1e-6

  # Equals for floats with tolerance
  def equals?(x, tolerance = EPISOLON)
    (self - x).abs < tolerance
  end
end
