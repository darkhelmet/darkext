require 'colored'
require 'darkext/fiber'
require 'darkext/string'
require 'darkext/symbol'

"Beagle.query is not secure! Use with caution".red.printn

module Beagle
  class BeagleError < RuntimeError; end

  class BeagleResultsHelper
    def initialize(io)
      @io = io
      @fiber = Fiber.new do
        while !@io.eof?
          result = Hash.new
          loop do
            line = @io.gets
            break if line.nil?
            if !line.include?('=') || line.starts_with?(' Snip')
              parts = line.split(':')
              k = parts.shift.strip
              break if result.keys.include?(k)
              v = parts.join(':').strip
              result[k] = v unless k.empty? || v.empty?
            elsif line.include?('=')
              k,v = line.split('=')
              k = k.split(':').last.strip
              break if result.keys.include?(k)
              v = v.gsub("'",'').strip
              result[k] = v unless k.empty? || v.empty?
            end
          end
          Fiber.yield(result)
        end
      end
    end

    def next
      begin
        return @fiber.resume
      rescue FiberError
        return nil
      end
    end

    def close
      @io.close
    end
  end

  def self.home
    ENV['BEAGLE_HOME']
  end

  def self.home=(home)
    ENV['BEAGLE_HOME'] = home
  end

  def self.start
    raise BeagleError, "Beagle.home (BEAGLE_HOME) not set!" if home.nil?
    system('beagled --backend Files')
  end

  def self.stop
    raise BeagleError, "Beagle.home (BEAGLE_HOME) not set!" if home.nil?
    system('beagle-shutdown')
  end

  def self.query(query, max_hits = 100)
    raise BeagleError, "Beagle.home (BEAGLE_HOME) not set!" if home.nil?
    args = Array.new
    args << 'beagle-query'
    args << '--verbose'
    args << '--max-hits'
    args << max_hits.to_s
    args << query
    cmd = args.join(' ')
    cmd.printn
    return BeagleResultsHelper.new(IO.popen(cmd))
  end

  def self.running?
    raise BeagleError, "Beagle.home (BEAGLE_HOME) not set!" if home.nil?
    return false if status.include?("Could not connect")
    return true
  end

  def self.status
    raise BeagleError, "Beagle.home (BEAGLE_HOME) not set!" if home.nil?
    DarkIO.capture_output(:stderr => false) { system('beagle-info','--status') }.strip
  end
end
