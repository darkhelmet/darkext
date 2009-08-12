require File.dirname(__FILE__) + '/spec_helper'

describe Array do
  before(:each) do
    @a = (1..5).to_a
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
    counts = [0,0,0,0,0]
    count = 1000000
    count.times do
      r = @a.random
      counts[r - 1] += 1
    end
    counts.each do |v|
      (v/count.to_f).should be_close(1/counts.size.to_f,0.001)
    end

    @a.include?(@a.random).should be_true
  end

  it 'should return an Array from randomize' do
    @a.randomize.should be_a_kind_of(Array)
  end

  it 'should return nil from sum, product and random if size == 0' do
    %w(sum product random).each do |method|
      Array.new.send(method.intern).should be_nil
    end
  end

  it 'should rotate properly' do
    @a.rotate
    @a.should == [2,3,4,5,1]
    @a.rotate
    @a.should == [3,4,5,1,2]
    @a.rotate(@a.size)
    @a.should == [3,4,5,1,2]
  end

  it 'should rotate reverse properly' do
    @a.rotate_reverse
    @a.should == [5,1,2,3,4]
    @a.rotate_reverse
    @a.should == [4,5,1,2,3]
    @a.rotate_reverse(@a.size)
    @a.should == [4,5,1,2,3]
  end

  it 'should sum properly' do
    @a.sum.should == 15
    [1].sum.should == 1
    %w(a b c).sum.should == 'abc'
    [1.0,0.1,0.01].sum.should == 1.11
  end

  it 'should do product properly' do
    @a.product.should == 120
    [1].product.should == 1
    ['a',3].product.should == 'aaa'
  end

  it 'should do squares properly' do
    @a.squares.should == [1,4,9,16,25]
    [1].squares.should == [1]
    @a.squares!
    @a.should == [1,4,9,16,25]
  end

  it 'should randomize' do
    @a.randomize.should_not == @a
    a = @a.clone
    @a.randomize!
    @a.should_not == a
  end
end
