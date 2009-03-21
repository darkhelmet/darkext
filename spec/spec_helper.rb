require 'rubygems'
require 'spec'

# gem install redgreen for colored test output
begin require "redgreen" unless ENV['TM_CURRENT_LINE']; rescue LoadError; end

path = File.expand_path(File.dirname(__FILE__) + "/../lib/")
$LOAD_PATH.unshift(path) unless $LOAD_PATH.include?(path)

require 'lib/darkext'

class Float
  def around(value,error = 0.001)
    self - error < value && self + error > value
  end
end
