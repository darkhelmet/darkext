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

  it 'should convert to range' do
    '1..10'.to_range.should == (1..10)
    '1...10'.to_range.should == (1...10)
    'a..z'.to_range.should == ('a'..'z')
    'a...z'.to_range.should == ('a'...'z')
  end

  it 'should be true' do
    %w(true TRUE True).each { |t| t.true?.should be_true }
  end

  it 'should be false' do
    %w(false FALSE False).each { |f| f.false?.should be_true }
  end

  it 'should start with' do
    'foobar'.starts_with?('foo').should be_true
    'foobar'.starts_with?('bar').should be_false
  end

  it 'should end with' do
    'foobar'.ends_with?('bar').should be_true
    'foobar'.ends_with?('foo').should be_false
  end
end
