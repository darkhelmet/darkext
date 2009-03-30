require File.dirname(__FILE__) + '/helper'

class StringTest < Test::Unit::TestCase
  def test_to_range
    assert_equal('1..10'.to_range, 1..10)
    assert_equal('1...10'.to_range, 1...10)
    assert_equal('a..z'.to_range, 'a'..'z')
    assert_equal('a...z'.to_range, 'a'...'z')
  end

  def test_exec
    assert_equal('whoami'.exec(:capture => true).chomp, ENV['USER'])
  end

  def test_true
    assert('true'.true?)
    assert('TRUE'.true?)
    assert('True'.true?)
  end

  def test_false
    assert('false'.false?)
    assert('FALSE'.false?)
    assert('False'.false?)
  end

  def test_starts_with
    assert('foobar'.starts_with?('foo'))
    assert(!'foobar'.starts_with?('bar'))
  end

  def test_ends_with
    assert('foobar'.ends_with?('bar'))
    assert(!'foobar'.ends_with?('foo'))
  end
end
