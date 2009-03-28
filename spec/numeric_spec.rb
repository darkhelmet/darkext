require File.dirname(__FILE__) + '/spec_helper'

describe Numeric do
  it 'should respond to the new methods' do
    [10,10.5].each do |num|
      num.should respond_to(*%w(square cube sqrt root ln log))
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
