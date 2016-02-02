require 'sinatra/base'

require_relative 'app/controllers/application_controller'

map('/') { run ApplicationController }
