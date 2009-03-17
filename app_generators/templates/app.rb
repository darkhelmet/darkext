# $:.unshift(File.dirname(__FILE__) + '/lib')

%w(sinatra/base darkext darkext/sinatra).each { |lib| require lib }
FileList['lib/*.rb'].each { |file| load file }

class <%= app_name.capitalize %>Site
  register Sinatra::DarkHelpers
  <% for lib in %w(Options Helpers Extras Error Get Post Put Delete) %>
  register Sinatra::<%= app_name.capitalize %><%= lib %><% end %>
end

<%= app_name.capitalize %>Site.run!(:app_file => __FILE__) if __FILE__ == $0
