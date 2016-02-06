class LogoutController < ApplicationController
  get '/' do
    session[:user] = nil
    redirect '/'
  end
end
