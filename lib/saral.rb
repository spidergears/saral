# saral/lib/saral.rb
require "saral/version"
require "saral/routing"
require "saral/controller"

module Saral
  class Application
    def call(env)
      p env["PATH_INFO"]
      return [302,{"Location" => "http://localhost:9292/courses/create"},[]] if env["PATH_INFO"] == "/"
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      [200, {'Content-Type' => 'text/html'}, [text]]
    end
  end
end
