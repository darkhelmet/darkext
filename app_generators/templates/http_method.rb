module Sinatra
  module <%= app_name.capitalize %><%= method.capitalize %>
    def self.registered(app)
    end
  end

  register <%= app_name.capitalize %><%= method.capitalize %>
end
