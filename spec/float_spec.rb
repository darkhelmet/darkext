require File.dirname(__FILE__) + '/spec_helper'

describe Float do
  it 'should respond to the new methods' do
    1.0.should respond_to(*%w(equals?))
  end

  it 'should return a boolean from equals?' do
    1.0.equals?(1.0000001).is_boolean?.should be_true
  end
end
