require 'darkext/io'
require 'darkext/symbol'
require 'extensions/string'

module Beagle
  class BeagleError < RuntimeError
    def initialize(msg)
      super(msg)
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

  def self.query(query, verbose = false, max_hits = 40)
    raise BeagleError, "Beagle.home (BEAGLE_HOME) not set!" if home.nil?
    args = Array.new
    args << 'beagle-query'
    args << '--verbose' if verbose
    args << '--max-hits'
    args << max_hits.to_s
    args << query
    output = DarkIO.capture_output(:stderr => false) { system(*args) }
    parser = verbose ? verbose_parser : regular_parser
    parser.call(output)
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

private

  def self.verbose_parser
    lambda do |output|
      sections = output.strip.split("\n\n")
      results = sections.map do |section|
        section_lines = section.split("\n")
        section_hash = Hash.new
        section_lines.each do |line|
          if !line.include?('=') || line.starts_with?(' Snip')
            parts = line.split(':')
            k = parts.shift
            v = parts.join(':')
            section_hash[k.strip] = v.strip
          elsif line.include?('=')
            k,v = line.split('=')
            k = k.split(':').last
            v.gsub!("'",'')
            section_hash[k.strip] = v.strip
          end
        end
        section_hash
      end
      results.sort { |l,r| l['Score'].to_f <=> r['Score'].to_f }
    end
  end

  def self.regular_parser
    lambda do |output|
      output.split("\n").map(&:strip)
    end
  end
end
