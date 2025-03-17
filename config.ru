require 'rack'
require './src/rack.rb'

use Rack::Static, urls: ["/static"]
run RackApp.new
