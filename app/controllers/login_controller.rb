class LoginController < ApplicationController
  get '/' do
    slim :'login/login'
  end
end
