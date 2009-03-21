require File.dirname(__FILE__) + '/spec_helper'

describe Float do
  it 'should respond to the new methods' do
    %w(equals?).each { |method| 1.0.respond_to?(method).should == true }
  end

  it 'should return a boolean from equals?' do
    1.0.equals?(1.0000001).is_boolean?.should == true
  end
end
