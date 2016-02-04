class LogoutController < ApplicationController
  get '/' do
    session[:user] = nil
    redirect to '../'
  end
end
