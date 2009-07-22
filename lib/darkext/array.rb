require 'darkext/numeric'
require 'darkext/symbol'

class Array
  # Rotates the array left by n elements
  def rotate(n = 1)
    return if self.size.zero?
    n.times { self.push(self.shift) }
  end

  # Rotates the array right by n elements
  def rotate_reverse(n = 1)
    return if self.size.zero?
    n.times { self.unshift(self.pop) }
  end

  # Sums the array
  def sum
    self.inject(&:+)
  end

  # Finds the product of the array
  def product
    self.inject(&:*)
  end

  # Collects the squares of each value in the array
  def squares
    self.map(&:square)
  end

  # Destructively collects the squares
  def squares!
    self.map!(&:square)
  end

  # Picks a random value from the array
  def random
    self[rand(self.size)]
  end
  alias :pick :random

  # Randomizes the array
  def randomize
    self.sort_by { rand }
  end

  # Destructively randomizes
  def randomize!
    self.replace(self.randomize)
  end
end
