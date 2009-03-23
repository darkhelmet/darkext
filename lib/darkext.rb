$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

libs = Dir[File.join(File.join(File.dirname(__FILE__), 'darkext'), '*.rb')]

# Don't load these by default
other_libs = libs.reject! { |lib| lib.include?('sinatra') || lib.include?('sitemap') }

libs.reject! { |lib| lib.include?('beagle') }.first
libs.each { |lib| require lib }

# autoload beagle
autoload(:Beagle, 'darkext/beagle')
