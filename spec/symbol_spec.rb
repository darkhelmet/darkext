require File.dirname(__FILE__) + '/spec_helper'

describe Symbol do
  it 'should respond to the new methods' do
    Proc.new{ }.should respond_to(*%w(to_proc))
  end

  it 'should return a Proc from to_proc' do
    :foo.to_proc.should be_a_kind_of(Proc)
  end

  it 'should properly to do to_proc' do
    'abc'.map(&:upcase).first.should == 'ABC'
    [1,2,3,4].map(&:square).should == [1,4,9,16]
  end
end
