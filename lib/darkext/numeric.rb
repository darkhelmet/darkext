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
end
