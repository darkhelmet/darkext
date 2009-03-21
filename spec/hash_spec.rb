require File.dirname(__FILE__) + '/spec_helper'

describe Hash do
  before(:each) do
    @hash = Hash.new
  end

  it 'should respond to all the new methods' do
    %w(with_defaults with_defaults! nested_find deep_merge! nested_hash merge_nested_hash!).each { |method| @hash.respond_to?(method).should == true }
  end

  it 'should return a hash from with_defaults' do
    @hash.with_defaults(:foo => :bar).is_a?(Hash).should == true
  end
end
