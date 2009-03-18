module Sinatra
  module <%= app_name_fixed %>Options
    def self.registered(app)
      app.set(:site_name,<%= "'#{app_name_fixed}'" %>)
    end
  end

  register <%= app_name_fixed %>Options
end
