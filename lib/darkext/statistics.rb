require 'mathn'

require 'darkext/array'
require 'darkext/numeric'
require 'darkext/symbol'

class Array
  # Finds the mean of the array
  def mean
    self.sum / self.size.to_f
  end
  alias :average :mean
  alias :ave :mean

  # Finds the median of the array
  def median
    return nil if self.size.zero?
    case self.size % 2
    when 0
      return self.sort[self.size / (2 - 1), 2].mean
    when 1
      return self.sort[self.size / 2]
    end
  end

  # Generates a histogram hash for the array
  def histogram(bins = nil)
    self.sort.inject({}) do |a,x|
      a[x] = a[x].to_i + 1
      a
    end
  end

  # Finds the mode of the array
  def mode
    map = self.histogram
    max = map.values.max
    map.keys.select{ |x| map[x] == max}
  end

  # Finds the variance of the array
  def variance
    (self.sum_of_squares.to_f / self.size.to_f) - self.mean.square
  end

  # Finds the standard deviation of the array
  def deviation
    self.variance.sqrt
  end

  # Randomly samples n elements
  def sample(n = 1)
    (1..n).collect { self[rand(self.size)] }
  end

  # Makes a two sided confidence interval for the array
  # Percent must be 0 < percent < 1 for this to work properly
  def ci(percent = 0.95, rho = 1)
    m = self.mean
    i = ((Statistics.zscore((1 - percent) / 2) * rho) /
         self.size.sqrt).abs
    [m - i, m + i]
  end

  # Standardizes the array
  def standardize
    m = self.mean.to_f
    rho = self.deviation.to_f
    self.map do |v|
      (v.to_f - m) / rho
    end
  end
end

module Statistics
  # Finds the probability of a z-score
  def self.prob(z)
    p = Math.erf(z.abs/2.sqrt) / 2
    return 0.5 + p if 0 < z
    return 0.5 - p
  end

  # Finds the zscore of a probability
  def self.zscore(p, epsilon = 0.00000000000001)
    return -1 if (1 < p || 0 > p)
    minz, maxz = -6, 6
    zscore = 0.5
    prob = 0
    while (maxz - minz) > epsilon
      prob = prob(zscore)
      if prob > p then maxz = zscore else minz = zscore end
      zscore = (maxz + minz) * 0.5
    end
    return zscore
  end

  # Finds a two tail p-val for a high/low array
  def self.p_val(r, n = 30, rho = 1, mu = r.mean)
    probs = r.map do |x|
      (x - mu) / (rho / n.sqrt)
    end.map do |x|
      Statistics.prob(x)
    end
    return 1 - (probs[1] - probs[0])
  end

  module Statistics::Regression
    # Do a least squares linear regression on the two sets of x's and y's
    # Returns a hash containing many relevant values
    # * n (:n)
    # * B_1 (:b_1)
    # * B_0 (:b_0)
    # * predicted values (:predicted)
    # * residuals (:residuals)
    # * SS_E (:ss_e)
    # * unbiased estimator (:estimator)
    # * the equation as a lambda (:equation)
    # Raises an argument error if the arguments are not the same size
    def self.least_squares(xs,ys)
      raise ArgumentError("Arguments must be of equal size") if xs.size != ys.size
      n = xs.size
      b_1 = (xs.zip(ys).map(&:*).sum - ((ys.sum * xs.sum)/n))/(xs.map(&:square).sum - (xs.sum.square/n))
      b_0 = ys.mean - b_1 * xs.mean
      equation = lambda { |x| b_0 + b_1 * x }
      predicted = xs.map(&lambda)
      residuals = ys.zip(predicted).map(&:-)
      ss_e = residuals.map(&:square).sum
      estimator = ss_e/(n - 2)
      reg = Hash.new
      reg[:n] = n
      reg[:b_1] = b_1
      reg[:b_0] = b_0
      reg[:predicted] = predicted
      reg[:residuals] = residuals
      reg[:ss_e] = ss_e
      reg[:estimator] = estimator
      reg[:equation] = equation
      return reg
    end
  end
end
