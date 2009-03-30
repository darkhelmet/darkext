require File.dirname(__FILE__) + '/helper'

class BooleanTest < Test::Unit::TestCase
  def test_is_boolean
    assert(true.is_boolean?)
    assert(false.is_boolean?)
    assert_equal(1.is_boolean?, false)
    assert_equal('true'.is_boolean?, false)
    assert_equal(:true.is_boolean?, false)
  end

  def test_true_intern
    assert_equal(true.intern, :true)
  end

  def test_false_intern
    assert_equal(false.intern, :false)
  end
end
