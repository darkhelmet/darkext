require File.dirname(__FILE__) + '/spec_helper'

describe Hash do
  before(:each) do
    @h = { :foo => 1, :bar => 2, :baz => 3 }
    @nh = { :foo => { :bar => 2 }, :baz => { :biz => 4 } }
  end

  it 'should respond to all the new methods' do
    Hash.new.should respond_to(*%w(nested_find deep_merge!))
  end

  it 'should deep merge' do
    a = { :foo => 1, :bar => { :baz => 10, :biz => { :hello => :world }}}
    b = { :pickles => true, :sandwich => { :ham => 2, :bread => { :grains => :whole }}}
    result = { :foo => 1, :pickles => true, :sandwich => { :ham => 2, :bread => { :grains => :whole }}, :bar => { :baz => 10, :biz => { :hello => :world }}}
    a.deep_merge!(b)
    a.should == result
  end

  it 'should find nested things' do
    @nh.nested_find(:baz,:biz).should == 4
    @nh.nested_find(:foo,:bar).should == 2
    @nh.nested_find(:foo,:biz).should be_nil
  end
end
