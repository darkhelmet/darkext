require File.dirname(__FILE__) + '/spec_helper'

describe Array do
  before(:each) do
    @a = [1,2,3,4,5,6,7,8,9,10]
  end

  it 'should respond to all the new methods' do
    %w(rotate rotate_reverse sum product squares squares! random pick randomize randomize!).each { |method| [1].methods.include?(method).should == true }
  end

  it 'should not remove or add elements when randomizing' do
    @a.randomize.size.should == @a.size
  end

  it 'should rotate back to normal' do
    b = @a.clone
    b.rotate(b.size)
    b.should == @a
  end

  it 'should rotate reverse back to normal' do
    b = @a.clone
    b.rotate_reverse(b.size)
    b.should == @a
  end

  it 'should return a Numeric from sum and sum' do
    @a.sum.should be_a_kind_of(Numeric)
    @a.product.should be_a_kind_of(Numeric)
  end

  it 'should return an array of equal size from squares' do
    squares = @a.squares
    squares.should be_a_kind_of(Array)
    squares.size.should == @a.size
  end

  it 'should destructively collect squares' do
    b = @a.clone
    b.squares!.should == @a.squares
  end

  it 'should pick randomly' do
    counts = [0,0,0,0,0,0,0,0,0,0]
    count = 1000000
    count.times do
      r = @a.random
      counts[r - 1] += 1
    end
    counts.each { |v| (v/count.to_f).around(1/counts.size.to_f).should == true }
  end

  it 'should return an Array from randomize' do
    @a.randomize.should be_a_kind_of(Array)
  end
end
