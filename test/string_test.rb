require File.dirname(__FILE__) + '/helper'

class StringTest < Test::Unit::TestCase
  def test_to_range
    assert_equal('1..10'.to_range, 1..10)
    assert_equal('1...10'.to_range, 1...10)
    assert_equal('a..z'.to_range, 'a'..'z')
  end

  def test_exec
    assert_equal('whoami'.exec(:capture => true).chomp, ENV['USER'])
  end
end
