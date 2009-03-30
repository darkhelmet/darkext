require File.dirname(__FILE__) + '/helper'

class StatisticsTest < Test::Unit::TestCase
  def setup
    @hist = [1,2,1,1,3,2,1,1,3,3,3,3,3,2,2,1]
    @a = [5,1,9,12,6,7,8,8,8,1,2,3,4]
  end

  def test_mean
    assert_equal([1,2,3,4,5,6].mean, 3.5)
    assert_equal([1].mean, 1)
  end

  def test_harmonic_mean
    assert_in_delta([60,40].harmonic_mean, 48.to_f, 0.0001)
    assert_in_delta([9].harmonic_mean, 9.to_f, 0.0001)
  end

  def test_geometric_mean
    assert_equal([2,8].geometric_mean, 4)
    assert_in_delta([9].geometric_mean, 9.to_f, 0.0001)
  end

  def test_median
    assert_equal([1,2,3].median, 2)
    assert_equal([1].median, 1)
    assert_equal([2,4,6,8].median, 5)
  end

  def test_histogram
    assert_equal(@hist.histogram,{ 1 => 6, 2 => 4, 3 => 6 })
  end

  def test_mode
    assert_equal(@hist.mode, [1, 3])
    assert_equal((@hist + [1]).mode, [1])
  end

  def test_variance
    assert_in_delta([1,2,3,4,5,6].variance, 35/12, 0.0001)
    assert_in_delta([1].variance, 0.to_f, 0.0001)
    assert_in_delta([1,1].variance, 0.to_f, 0.0001)
    assert_in_delta(@a.variance, 10.5, 0.05)
  end

  def test_standard_deviation
    assert_in_delta([2,4,4,4,5,5,7,9].stddev, 2, 0.0001)
    assert_in_delta(@a.stddev, 3.24, 0.01)
  end

  def test_sample
    assert_equal(@hist.sample(5).size, 5)
  end

  def test_ci
    ci = @a.ci
    assert_in_delta(ci.shift, 5.15, 0.01)
    assert_in_delta(ci.shift, 6.24, 0.01)
    assert_in_delta(@a.ci(:type => :upper).shift, 6.15, 0.01)
    assert_in_delta(@a.ci(:type => :lower).shift, 5.24, 0.01)
  end

  def test_standardize
    assert_equal([2,2,4,4].standardize, [-1.0,-1.0, 1.0, 1.0])
    assert_equal(@a.standardize.size, 13)
  end

  def test_sum_of_squares
    assert_equal([1,2,3].sum_of_squares, 2.0)
  end

  def test_prob
    assert_in_delta(Darkext::Statistics::prob(2), 0.96, 0.02)
    assert_in_delta(Darkext::Statistics::prob(0.5), 0.69, 0.02)
    assert_in_delta(Darkext::Statistics::prob(Darkext::Statistics::zscore(1)), 1, 0.0001)
  end

  def test_zscore
    assert_in_delta(Darkext::Statistics::zscore(0.5), 0, 0.1)
    assert_in_delta(Darkext::Statistics::prob(0.75), 0.77, 0.02)
    assert_in_delta(Darkext::Statistics::zscore(Darkext::Statistics::prob(2.5)), 2.5, 0.0001)
  end

  def test_regession
    xs = [0,1.2,2,2.9,4,5,6]
    ys = [0.1,1,2.1,3,4.3,4.9,6]
    results = Darkext::Statistics::Regression::least_squares(xs,ys)
    assert_equal(results[:n],xs.size)
    assert_in_delta(results[:b_1], 1, 0.1)
    assert_in_delta(results[:b_0], 0, 0.1)
    assert_equal(results[:predicted].size, xs.size)
    results[:predicted].each_with_index do |pred,index|
      assert_in_delta(pred, index, 0.3)
    end
    assert_equal(results[:residuals].size, xs.size)
    results[:residuals].each_with_index do |pred,index|
      assert_in_delta(pred, 0, 0.3)
    end
    assert_in_delta(results[:ss_e], 0.15, 0.01)
    assert_in_delta(results[:ss_t], 27.49, 0.01)
    assert_in_delta(results[:estimator], 0.03, 0.01)
    assert_in_delta(results[:r_2], 1, 0.01)
    assert_in_delta(results[:r], 1, 0.01)
    eqn = results[:equation]
    (0..100).each do |i|
      assert_in_delta(eqn.call(i), i, 0.25)
    end
  end
end
