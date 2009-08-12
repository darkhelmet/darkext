require File.dirname(__FILE__) + '/spec_helper'

describe Fiber do
  before(:each) do
    @fiber = Fiber.new do
      (1..10).each { |i| Fiber.yield(i) }
    end
  end

  it 'should respond to all the class methods' do
    Fiber.should respond_to(*%w(yield current))
  end

  it 'should respond to all the instance methods' do
    @fiber.should respond_to(*%w(resume yield))
  end

  it 'should raise an error when it is done' do
    lambda { 100.times { @fiber.resume } }.should raise_error
  end

  it 'should return a string from inspect' do
    @fiber.inspect.should be_a_kind_of(String)
  end

  it 'should inspect properly' do
    @fiber.inspect.should match(/.*Fiber:0x/)
  end

  it 'should, um, work' do
    a = Array.new
    10.times { a << @fiber.resume }
    a.should == (1..10).to_a
  end
end
