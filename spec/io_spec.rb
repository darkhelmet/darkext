require File.dirname(__FILE__) + '/spec_helper'

describe DarkIO do
  it 'should return an array of size 2 when capturing both stdout and stderr' do
    out = DarkIO::capture_output(:stderr => true, :stdout => true) do
      STDOUT.print('Hello, World!')
      STDERR.print('Hello, World!')
    end
    out.should be_a_kind_of(Array)
    out.size.should == 2
  end

  it 'should return a string when capturing either stdout or stderr' do
    out = DarkIO::capture_output(:stderr => true, :stdout => false) do
      STDERR.print('Hello, World!')
    end
    out.should be_a_kind_of(String)
    out = DarkIO::capture_output(:stdout => true, :stderr => false) do
      STDOUT.print('Hello, World!')
    end
    out.should be_a_kind_of(String)
  end

  it 'should return nil if not capturing anything' do
    DarkIO::capture_output(:stderr => false, :stdout => false) do
      STDOUT.print('Hello, World!')
      STDERR.print('Hello, World!')
    end.nil?.should == true
  end
end
