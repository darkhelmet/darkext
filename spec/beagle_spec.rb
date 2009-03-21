require File.dirname(__FILE__) + '/spec_helper'

describe Beagle do
  it 'should respond to all the methods' do
    %w(home home= start stop status query running?).each do |method|
      Beagle.respond_to?(method).should == true
    end
  end
end
