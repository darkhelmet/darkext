require File.dirname(__FILE__) + '/helper'

class SymbolTest < Test::Unit::TestCase
  def test_to_proc
    assert_equal('abcde'.map(&:upcase).first,'ABCDE')
    assert_equal([1,2,3,4].map(&:square),[1,4,9,16])
  end
end
