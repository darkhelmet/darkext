require File.dirname(__FILE__) + '/spec_helper'

describe Net do
  it 'should respond to the new methods' do
    %w(download download_and_save).each do |method|
      Net.respond_to?(method).should == true
    end
  end

  it 'should raise an exception on 404' do
    begin
      Net::download('http://www.google.com/pickles.html')
      # die here
      false.should == true
    rescue
      true.should == true
    end
  end

  it 'should raise an exception when trying to save an empty path' do
    begin
      Net::download_and_save('http://www.google.com/','')
      # die here
      false.should == true
    rescue
      true.should == true
    end
  end

  it 'should not write anything to the disk if not success' do
    begin
      Net::download_and_save('http://www.google.com/pickles.html')
    rescue
    end
    File.exists?('pickles.html').should == false
  end
end
