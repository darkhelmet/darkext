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

  it 'should do squares' do
    4.square.should == 16
    -4.square.should == 16
  end

  it 'should do cubes' do
    3.cube.should == 27
    -3.cube.should == -27
  end

  it 'should do square roots' do
    9.sqrt.should == 3
    81.sqrt.should == 9
  end

  it 'should do roots' do
    9.sqrt.should == 9.root
    27.root(3).should == 3
    81.root(4).should == 3
    5.root(1).should == 5
    10.root(-1).should == 0.1
    100.root(-2).should == 0.1
  end

  it 'should do ln' do
    Math::E.ln.should == 1
    Math::PI.ln.should be_close(1.14473, 0.001)
  end

  it 'should do log' do
    10.log.should == 1
    100.log.should == 2
    Math::PI.log.should be_close(0.4971, 0.0001)
  end
end
