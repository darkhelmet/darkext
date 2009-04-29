#!/usr/bin/env ruby

%w(rubygems haml sinatra/base darkext darkext/sinatra).each { |lib| require lib }
Dir['lib/*.rb'].each { |file| load file }

load 'local_options.rb' if File.exists?('local_options.rb')

class <%= app_name_fixed %>Site < Sinatra::Default
  set(:app_file, File.expand_path(__FILE__))
  register Sinatra::DarkHelpers
  <% for lib in %w(Options Helpers Error Get Post Put Delete) %>
  register Sinatra::<%= app_name_fixed %><%= lib %><% end %>
  register Sinatra::LocalOptions unless defined?(Sinatra::LocalOptions).nil?
end

<%= app_name_fixed %>Site.run! if __FILE__ == $0
