require File.dirname(__FILE__) + '/helper'

class FloatTest < Test::Unit::TestCase
  def test_equals
    assert(1.00000000000000001.equals?(1.00000000000000002))
    assert(!1.1.equals?(1.2))
    assert(1.1.equals?(1.2,0.1))
    assert(1.2.equals?(1.1,0.1))
  end
end
