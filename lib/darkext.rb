$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

Dir[File.join(File.join(File.dirname(__FILE__), 'darkext'), '*.rb')].sort.each do |lib|
  # don't include sinatra stuff by defaults
  require lib unless lib.include?('sinatra') || lib.include?('sitemap')
end
