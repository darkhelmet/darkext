module Sinatra
  module <%= app_name_fixed %>Error
    def self.registered(app)
    end
  end

  register <%= app_name_fixed %>Error
end
