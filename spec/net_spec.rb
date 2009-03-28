require File.dirname(__FILE__) + '/spec_helper'

describe Net do
  it 'should respond to the new methods' do
    Net.should respond_to(*%w(download download_and_save))
  end

  it 'should raise an exception on 404' do
    lambda { Net::download('http://www.google.com/pickles.html') }.should raise_error
  end

  it 'should raise an exception when trying to save an empty path' do
    lambda { Net::download_and_save('http://www.google.com/','') }.should raise_error
  end

  it 'should not write anything to the disk if not success' do
    begin
      Net::download_and_save('http://www.google.com/pickles.html')
    rescue
    end
    File.exists?('pickles.html').should be_false
  end
end
