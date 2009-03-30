require File.dirname(__FILE__) + '/helper'

class Foo
  def add(n)
    42 + n
  end
end


class ObjectTest < Test::Unit::TestCase
  def test_try
    assert_nil(nil.try { |me| me.foo })
    assert(true.try { |me| me })
    assert_not_nil(true.try(:nil?))
    assert_equal(Foo.new.try(:add,10),52)
  end

  def test_tap
    f = Foo.new
    assert_equal(f.tap { |me| assert_equal(me,f) }, f)
  end
end
