require File.dirname(__FILE__) + '/spec_helper'

describe Fiber do
  before(:each) do
    @fiber = Fiber.new do
      (1..10).each { |i| Fiber.yield }
    end
  end

  it 'should respond to all the class methods' do
    %w(yield current).each { |method| Fiber.respond_to?(method).should == true }
  end

  it 'should respond to all the instance methods' do
    %w(resume yield).each { |method| @fiber.respond_to?(method).should == true }
  end

  it 'should raise an error when it is done' do
    begin
      100.times { @fiber.resume }
      # should break before this
      true.should == false
    rescue
      $!.is_a?(FiberError).should == true
    end
  end
end
