require 'slim'
run do |env|
    env["rack.body"] = env['rack.input'].read
    out = Slim::Template.new("./src/pasterb.slim").render(Object.new, rackenv: env)
    [200, {}, [out]]
end
