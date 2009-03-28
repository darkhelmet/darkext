require File.dirname(__FILE__) + '/spec_helper'

describe Hash do
  it 'should respond to all the new methods' do
    Hash.new.should respond_to(*%w(with_defaults with_defaults! nested_find deep_merge! nested_hash merge_nested_hash!))
  end

  it 'should return a hash from with_defaults' do
    Hash.new.with_defaults(:foo => :bar).should be_a_kind_of(Hash)
  end
end
