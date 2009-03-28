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
end
