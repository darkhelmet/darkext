require File.dirname(__FILE__) + '/spec_helper'

describe Beagle do
  it 'should respond to all the methods' do
    Beagle.should respond_to(*%w(home home= start stop status query running?))
  end

  it 'should not work if Beagle.home is nil' do
    Beagle.home = nil
    lambda { Beagle.start }.should raise_error
  end

  it 'should return a true or false value from running' do
    # TODO: use temp dir
    Beagle.home = '/balls'
    Beagle.running?.is_boolean?.should be_true
  end

  it 'should probably not be running for a random directory' do
    # TODO: use temp dir
    Beagle.home = '/balls'
    Beagle.running?.should be_false
  end

  it 'should return a String for the status' do
    # TODO: use temp dir
    Beagle.home = '/balls'
    Beagle.status.should be_a_kind_of(String)
  end

  it 'should return a true or false value from start' do
    # TODO: use temp dir
    Beagle.home = '/usr'
    Beagle.start.is_boolean?.should be_true
  end

  it 'should return a true or false value from stop' do
    # TODO: use temp dir
    Beagle.home = '/usr'
    Beagle.stop.is_boolean?.should be_true
  end
end
