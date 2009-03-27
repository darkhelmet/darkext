require File.dirname(__FILE__) + '/spec_helper'

describe Integer do
  it 'should respond to the new methods' do
    %w(fact).each do |method|
      10.respond_to?(method).should == true
    end
  end

  it 'should not calculate the factorial of negative numbers' do
    begin
      -10.fact
      # fail if we get here
      false.should == true
    rescue
      true.should == true
    end
  end

  it 'should return an Integer from factorial' do
    10.fact.should be_a_kind_of(Integer)
  end
end
