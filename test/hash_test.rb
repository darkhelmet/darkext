require File.dirname(__FILE__) + '/helper'

class HashTest < Test::Unit::TestCase
  def setup
    @h = { :foo => 1, :bar => 2, :baz => 3 }
    @nh = { :foo => { :bar => 2 }, :baz => { :biz => 4 } }
  end

  def test_with_defaults
    assert_equal(@h.with_defaults(:biz => 4), { :foo => 1, :bar => 2, :baz => 3, :biz => 4 })
    assert_equal(@h.with_defaults(:foo => 5), { :foo => 1, :bar => 2, :baz => 3 })
    @h.with_defaults!(:biz => 4)
    assert_equal(@h, { :foo => 1, :bar => 2, :baz => 3, :biz => 4 })
  end

  def test_nested_find
    assert_equal(@nh.nested_find(:baz,:biz), 4)
    assert_equal(@nh.nested_find(:foo,:bar), 2)
    assert_nil(@nh.nested_find(:foo,:biz))
  end

  def test_deep_merge
    a = { :foo => 1, :bar => { :baz => 10, :biz => { :hello => :world }}}
    b = { :pickles => true, :sandwich => { :ham => 2, :bread => { :grains => :whole }}}
    result = { :foo => 1, :pickles => true, :sandwich => { :ham => 2, :bread => { :grains => :whole }}, :bar => { :baz => 10, :biz => { :hello => :world }}}
    a.deep_merge!(b)
    assert_equal(a,result)
  end
end
