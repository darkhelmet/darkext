require File.dirname(__FILE__) + '/spec_helper'

describe Float do
  it 'should respond to the new methods' do
    1.0.should respond_to(*%w(equals?))
  end

  it 'should return a boolean from equals?' do
    1.0.equals?(1.0000001).is_boolean?.should be_true
  end

  it 'should properly equals' do
    1.00000000000000001.equals?(1.00000000000000002).should be_true
    1.1.equals?(1.2).should be_false
    1.1.equals?(1.2,0.1).should be_true
    1.2.equals?(1.1,0.1).should be_true
  end
end
