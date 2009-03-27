require File.dirname(__FILE__) + '/spec_helper'

describe Numeric do
  it 'should respond to the new methods' do
    %w(square cube sqrt root ln log).each do |method|
      [10,10.5].each do |num|
        num.respond_to?(method).should == true
      end
    end
  end

  it 'should return Numeric from most new methods' do
    %w(square cube sqrt root ln log).each do |method|
      [10,10.5].each do |num|
        num.send(method.intern).should be_a_kind_of(Numeric)
      end
    end
  end
end
