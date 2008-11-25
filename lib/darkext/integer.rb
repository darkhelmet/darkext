require 'darkext/array'

class Integer
  # Computes the factorial of the Integer
  def fact
    raise ArgumentError.new("Cannot compute factorial of negative number") if 0 > self
    return 1 if self.zero?
    return (1..self).to_a.product
  end
end
