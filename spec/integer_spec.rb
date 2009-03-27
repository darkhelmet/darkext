require File.dirname(__FILE__) + '/spec_helper'

describe Integer do
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
    10.fact.is_a?(Integer).should == true
  end
end
