require File.dirname(__FILE__) + '/spec_helper'

describe Integer do
  it 'should respond to the new methods' do
    10.should respond_to(*%w(fact))
  end

  it 'should not calculate the factorial of negative numbers' do
    lambda { -10.fact }.should raise_error
  end

  it 'should return an Integer from factorial' do
    10.fact.should be_a_kind_of(Integer)
  end
end
