require 'sinatra/base'
require 'mongoid'
require 'bcrypt'
require 'require_all'

require_rel 'app'

Mongoid.load!('mongoid.yml')

map('/') { run ApplicationController }
map('/register') { run RegisterController }
map('/login') { run LoginController }
map('/logout') { run LogoutController }
map('/day') { run DayController }
