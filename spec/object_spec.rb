require File.dirname(__FILE__) + '/spec_helper'

describe Object do
  it 'should respond to the new methods' do
    Object.new.should respond_to(*%w(try tap))
  end

  it 'should return itself from tap' do
    a = Object.new
    a.tap { |s| }.should equal(a)
  end

  it 'should return nil from try if called on nil' do
    nil.try(1) { |a| }.should be_nil
  end

  it 'should try...like really try' do
    nil.try { |me| me.foo }.should be_nil
    true.try { |me| me }.should be_true
    true.try(:nil?).should_not be_nil
  end

  it 'should tap dance' do
    10.tap { |m| m.should == 10 }.should == 10
    o = Object.new
    o.tap { |m| m.should == o }.should == o
  end
end
