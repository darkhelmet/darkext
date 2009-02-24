require 'sinatra/base'

module Sinatra
  module DarkHelpers
    module HelperMethods
      def view(view, options = {})
        html = haml(view,options)
        flash.clear
        html
      end

      def partial(page, options = {})
        # Can't make this use view() because of the flash.clear
        haml(page, options.merge!(:layout => false))
      end

      def css_link_tag(sheet, media = 'screen,projection')
        partial("%link{ :type => 'text/css', :href => 'stylesheets/#{sheet}.css', :rel => 'stylesheet', :media => '#{media}' }")
      end

      def js_script_tag(script)
        partial("%script{ :type => 'text/javascript', :src => 'javascripts/#{script}.js' }")
      end

      def js_tag(script)
        @dsh_script = script
        temp = ["%script{ :type => 'text/javascript' }",
                "  //<![CDATA[",
                "  = @dsh_script",
                "  //]]>"].join("\n")
        partial(temp)
      end

      def flash
        session[:flash] = {} if session[:flash] && session[:flash].class != Hash
        session[:flash] ||= {}
      end

      def host
        port = request.env['SERVER_PORT'].to_i
        port = port == 80 ? "" : ":#{port}"
        "#{protocol}://#{server_name}#{port}"
      end

      def protocol
        request.env['rack.url_scheme']
      end

      def server_name
        request.env['SERVER_NAME']
      end

      def set_title(extra)
        @title = "#{options.site_name} - #{extra}"
      end

      def base
        "#{host}#{options.site_base}"
      end
    end

    def self.registered(app)
      app.helpers HelperMethods
    end
  end

  register DarkHelpers
end
