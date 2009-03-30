require File.dirname(__FILE__) + '/helper'

class NumericTest < Test::Unit::TestCase
  def test_square
    assert_equal(4.square, 16)
    assert_equal(-4.square, 16)
  end

  def test_cube
    assert_equal(3.cube, 27)
    assert_equal(-3.cube, -27)
  end

  def test_sqrt
    assert_equal(9.sqrt, 3)
    assert_equal(81.sqrt, 9)
  end

  def test_root
    assert_equal(9.sqrt, 9.root)
    assert_equal(27.root(3), 3)
    assert_equal(81.root(4), 3)
    assert_equal(5.root(1), 5)
    assert_equal(10.root(-1), 0.1)
    assert_equal(100.root(-2), 0.1)
  end

  def test_ln
    assert_equal(Math::E.ln, 1)
    assert_in_delta(Math::PI.ln, 1.14473, 0.0001)
  end

  def test_log
    assert_equal(10.log, 1)
    assert_equal(100.log, 2)
    assert_in_delta(Math::PI.log, 0.4971, 0.0001)
  end
end

