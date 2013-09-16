# saral/lib/saral.rb
require "saral/version"
require "saral/routing"
require "saral/controller"

module Saral
  class Application
    def call(env)
      begin
        return [302,{"Location" => "http://localhost:#{env["SERVER_PORT"]}/courses/create"},[]] if env["PATH_INFO"] == "/"
        klass, act, args = get_controller_and_action(env)
        controller = klass.new(env)
        p "Arguements #{args}"
        if args
          text = controller.send(act, args)
        else
          text = controller.send(act)
        end
      rescue Exception 
        text = "An exception has occured"
      end

      [200, {'Content-Type' => 'text/html'}, [text]]
    end
  end
end
