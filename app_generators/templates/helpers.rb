module Sinatra
  module <%= app_name_fixed %>Helpers
    module HelperMethods
    end

    def self.registered(app)
      app.helpers(HelperMethods)
    end
  end

  register <%= app_name_fixed %>Helpers
end
