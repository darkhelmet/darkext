module Sinatra
  module <%= app_name.capitalize %>Helpers
    module HelperMethods
    end

    def self.registered(app)
      app.helpers(HelperMethods)
    end
  end

  register <%= app_name.capitalize %>Helpers
end
