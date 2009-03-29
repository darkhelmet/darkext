require File.dirname(__FILE__) + '/spec_helper'

describe String do
  it 'should respond to the new methods' do
    'foo'.should respond_to(*%w(to_range exec print printn true? false? starts_with? ends_with? /))
  end

  it 'should return a boolean from starts_with? and ends_with?' do
    'foo'.starts_with?('fo').is_boolean?.should be_true
    'foo'.ends_with?('oo').is_boolean?.should be_true
  end

  it 'should return a boolean from true? and false?' do
    'true'.true?.is_boolean?.should be_true
    'false'.false?.is_boolean?.should be_true
  end

  it 'should return the same thing from / as split' do
    'f.o.o'.split('.').should eql('f.o.o' / '.')
  end

  it 'should return a range from to_range if it works' do
    '1..5'.to_range.should be_a_kind_of(Range)
  end

  it 'should return nil if the range is not a valid format' do
    lambda { 'nipples'.to_range }.should raise_error
  end
end
