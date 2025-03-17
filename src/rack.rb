require 'slim'

class RackApp
    def call(env)
        env["rack.body"] = env['rack.input'].read
        out = Slim::Template.new("./src/pasterb.slim").render(Object.new, rackenv: env)
        [200, {}, [out]]
    end    
end
