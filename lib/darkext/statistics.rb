require 'mathn'

require 'darkext/array'
require 'darkext/numeric'
require 'darkext/symbol'

class Array
  # Finds the mean of the array
  def mean
    raise ArgumentError.new('Array size must be > 0') if self.size.zero?
    self.sum / self.size.to_f
  end
  alias :average :mean
  alias :ave :mean

  def harmonic_mean
    raise ArgumentError.new('Array size must be > 0') if self.size.zero?
    self.size.to_f / self.map { |i| 1 / i.to_f }.sum
  end
  alias :h_mean :harmonic_mean

  def geometric_mean
    raise ArgumentError.new('Array size must be > 0') if self.size.zero?
    self.product.root(self.size)
  end
  alias :g_mean :geometric_mean

  # Finds the median of the array
  def median
    raise ArgumentError.new('Array size must be > 0') if self.size.zero?
    case self.size % 2
    when 0
      return self.sort[(self.size / 2) - 1, 2].mean
    when 1
      return self.sort[self.size / 2]
    end
  end

  # Generates a histogram hash for the array
  def histogram
    self.sort.inject({}) do |a,x|
      a[x] = a[x].to_i + 1
      a
    end
  end

  # Finds the mode of the array
  def mode
    raise ArgumentError.new('Array size must be > 0') if self.size.zero?
    map = self.histogram
    max = map.values.max
    map.keys.select { |x| map[x] == max }
  end

  # Variance
  def variance
    raise ArgumentError.new('Array size must be > 0') if self.size.zero?
    self.sum_of_squares.to_f / (self.size).to_f
  end

  # Standard deviation
  def standard_deviation
    raise ArgumentError.new('Array size must be > 0') if self.size.zero?
    self.variance.abs.sqrt
  end
  alias :stddev :standard_deviation

  # Randomly samples n elements
  def sample(n = 1)
    (1..n).collect { self[rand(self.size)] }
  end

  # Generates a confidence interval
  def ci(opts = { })
    raise ArgumentError.new('Array size must be > 0') if self.size.zero?
    opts = { :percent => 0.95, :rho => 1, :type => :center }.merge(opts)
    percent = opts[:percent]
    rho = opts[:rho]
    m = self.mean
    ret = Array.new
    div = (opts[:type] == :center ? 2 : 1)
    i = ((Darkext::Statistics::zscore((1 - percent) / div) * rho) /
         self.size.sqrt).abs
    case opts[:type]
    when :center
      ret << m - i
      ret << m + i
    when :upper
      ret << m + i
    when :lower
      ret << m - i
    end
    return ret
  end

  # Standardizes the array
  def standardize
    self.clone.standardize!
  end

  # Destructive standardize
  def standardize!
    m = self.mean.to_f
    rho = self.standard_deviation.to_f
    self.map! { |v| (v.to_f - m) / rho }
  end

  def sum_of_squares
    raise ArgumentError.new('Array size must be > 0') if self.size.zero?
    m = self.mean
    self.map { |v| v - m }.squares.sum
  end
end

module Darkext
  module Darkext::Statistics
    # Finds the probability of a z-score
    def self.prob(z)
      p = Math::erf(z.abs/2.sqrt) / 2
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
        prob > p ? maxz = zscore : minz = zscore
        zscore = (maxz + minz) * 0.5
      end
      return zscore
    end

    # Finds a two tail p-val for a high/low array
    # can't remember how to use this
=begin
    def self.p_val(r, n = 30, rho = 1, mu = r.mean)
      probs = r.map do |x|
        (x - mu) / (rho / n.sqrt)
      end.map do |x|
        Statistics::prob(x)
      end
      return 1 - (probs[1] - probs[0])
    end
=end

    module Darkext::Statistics::Regression
      # Do a least squares linear regression on the two sets of x's and y's
      # Returns a hash containing many relevant values
      # * n (:n)
      # * B_1 (:b_1)
      # * B_0 (:b_0)
      # * predicted values (:predicted)
      # * residuals (:residuals)
      # * SSE (:ss_e)
      # * SST (:ss_t)
      # * R^2 (:r_2)
      # * R (:r)
      # * unbiased estimator (:estimator)
      # * the equation as a lambda (:equation)
      # Raises an argument error if the arguments are not the same size or either is zero
      def self.least_squares(xs,ys)
        raise ArgumentError.new('Arrays must have size > 0') if xs.size.zero? || ys.size.zero?
        raise ArgumentError.new('Arrays must be of equal size') if xs.size != ys.size
        n = xs.size
        b_1 = (xs.zip(ys).map(&:product).sum - ((ys.sum * xs.sum)/n))/(xs.map(&:square).sum - (xs.sum.square/n))
        b_0 = ys.mean - b_1 * xs.mean
        equation = lambda { |x| b_0 + b_1 * x }
        predicted = xs.map(&equation)
        residuals = ys.zip(predicted).map { |y| y.shift - y.shift }
        ss_e = residuals.map(&:square).sum
        ss_t = ys.sum_of_squares
        estimator = ss_e/(n - 2)
        r_2 = 1 - (ss_e/ss_t)
        r = r_2.sqrt
        reg = {
          :n => n,
          :b_1 => b_1,
          :b_0 => b_0,
          :predicted => predicted,
          :residuals => residuals,
          :ss_e => ss_e,
          :ss_t => ss_t,
          :estimator => estimator,
          :equation => equation,
          :r_2 => r_2,
          :r => r
        }
        return reg
      end
    end
  end
end
