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
  end

  def test_ln
  end

  def test_log
  end
end

