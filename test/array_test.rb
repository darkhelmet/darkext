require File.dirname(__FILE__) + '/helper'

class ArrayTest < Test::Unit::TestCase
  def setup
    @a = [1,2,3,4,5]
  end

  def test_rotate
    @a.rotate
    assert_equal(@a, [2,3,4,5,1])
    @a.rotate
    assert_equal(@a, [3,4,5,1,2])
    @a.rotate(@a.size)
    assert_equal(@a, [3,4,5,1,2])
  end

  def test_rotate_reverse
    @a.rotate_reverse
    assert_equal(@a, [5,1,2,3,4])
    @a.rotate_reverse
    assert_equal(@a, [4,5,1,2,3])
    @a.rotate_reverse(@a.size)
    assert_equal(@a, [4,5,1,2,3])
  end

  def test_sum
    assert_equal(@a.sum, 15)
    assert_equal([1].sum, 1)
    assert_equal(['a','b','c'].sum, 'abc')
    assert_equal([1.0,0.1,0.01].sum, 1.11)
  end

  def test_product
    assert_equal(@a.product, 120)
    assert_equal([1].product, 1)
    assert_equal(['a',3].product, 'aaa')
  end

  def test_squares
    assert_equal(@a.squares, [1,4,9,16,25])
    assert_equal([1].squares, [1])
    @a.squares!
    assert_equal(@a, [1,4,9,16,25])
  end

  def test_randomize
    assert_not_equal(@a.randomize, @a)
    a = @a.clone
    @a.randomize!
    assert_not_equal(a, @a)
  end

  def test_random
    assert(@a.include?(@a.random))
    left = Array.new
    right = Array.new
    10.times do
      left << @a.random
      right << @a.pick
    end
    assert_not_equal(left, right)
  end
end
