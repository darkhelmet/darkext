module Sinatra
  module <%= app_name_fixed %><%= method.capitalize %>
    def self.registered(app)
    end
  end

  register <%= app_name_fixed %><%= method.capitalize %>
end
