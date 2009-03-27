require File.dirname(__FILE__) + '/spec_helper'

describe Beagle do
  it 'should respond to all the methods' do
    %w(home home= start stop status query running?).each do |method|
      Beagle.respond_to?(method).should == true
    end
  end

  it 'should not work if Beagle.home is nil' do
    Beagle.home = nil
    begin
      Beagle.start
      # fail if we get here
      false.should == true
    rescue
      $!.should be_a_kind_of(Beagle::BeagleError)
    end
  end

  it 'should return a true or false value from running' do
    # TODO: use temp dir
    Beagle.home = '/balls'
    Beagle.running?.is_boolean?.should == true
  end

  it 'should probably not be running for a random directory' do
    # TODO: use temp dir
    Beagle.home = '/balls'
    Beagle.running?.should == false
  end

  it 'should return a String for the status' do
    # TODO: use temp dir
    Beagle.home = '/balls'
    Beagle.status.should be_a_kind_of(String)
  end

  it 'should return a true or false value from start' do
    # TODO: use temp dir
    Beagle.home = '/usr'
    Beagle.start.is_boolean?.should == true
  end

  it 'should return a true or false value from stop' do
    # TODO: use temp dir
    Beagle.home = '/usr'
    Beagle.stop.is_boolean?.should == true
  end
end
