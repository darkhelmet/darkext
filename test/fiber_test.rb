require File.dirname(__FILE__) + '/helper'

class FiberTest < Test::Unit::TestCase
  def test_fiber
    f = Fiber.new do
      (1..10).each do |i|
        Fiber.yield(i)
      end
    end
    assert_match(/.*Fiber:0x/,f.inspect)
    a = Array.new
    10.times { a << f.resume }
    assert_equal(a, [1,2,3,4,5,6,7,8,9,10])
  end
end
