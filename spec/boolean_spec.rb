require File.dirname(__FILE__) + '/spec_helper'

describe Object do
  it 'should respond to the new method' do
    Object.new.should respond_to(*%w(is_boolean?))
  end

  it 'should return a boolean from is_boolean' do
    true.is_boolean?.is_boolean?.should be_true
  end
end

describe TrueClass do
  it 'should respond to the new method' do
    true.should respond_to(*%w(intern))
  end

  it 'should return a symbol from intern' do
    true.intern.should be_a_kind_of(Symbol)
  end
end

describe FalseClass do
  it 'should respond to the new method' do
    false.should respond_to(*%w(intern))
  end

  it 'should return a symbol from intern' do
    false.intern.should be_a_kind_of(Symbol)
  end
end
