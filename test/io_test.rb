require File.dirname(__FILE__) + '/helper'

class TestDarkIO < Test::Unit::TestCase
  HW = 'Hello, World!'
  def test_capture_output
    out = DarkIO::capture_output do
      HW.print
    end
    assert_equal(out, HW)
    out = DarkIO::capture_output(:stderr => true) do
      (HW + 'STDOUT').print
      STDERR.print(HW + 'STDERR')
    end
    assert_equal(out.shift, HW + 'STDOUT')
    assert_equal(out.shift, HW + 'STDERR')
    out = DarkIO::capture_output(:stderr => true, :stdout => false) do
      STDERR.print(HW)
    end
    assert_equal(out, HW)
  end
end
