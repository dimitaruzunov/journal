require 'sinatra/base'
require 'mongoid'

require_relative 'app/models/user'

require_relative 'app/helpers/application_helpers'

require_relative 'app/controllers/application_controller'
require_relative 'app/controllers/register_controller'
require_relative 'app/controllers/login_controller'

Mongoid.load!('mongoid.yml')

map('/') { run ApplicationController }
map('/register') { run RegisterController }
map('/login') { run LoginController }
