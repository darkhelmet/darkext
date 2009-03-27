require File.dirname(__FILE__) + '/spec_helper'

describe Object do
  it 'should respond to the new method' do
    a = Object.new
    a.respond_to?('is_boolean?').should == true
  end

  it 'should return a boolean from is_boolean' do
    true.is_boolean?.is_boolean?.should == true
  end
end

describe TrueClass do
  it 'should respond to the new method' do
    true.respond_to?('intern').should == true
  end

  it 'should return a symbol from intern' do
    true.intern.should be_a_kind_of(Symbol)
  end
end

describe FalseClass do
  it 'should respond to the new method' do
    false.respond_to?('intern').should == true
  end

  it 'should return a symbol from intern' do
    false.intern.should be_a_kind_of(Symbol)
  end
end
