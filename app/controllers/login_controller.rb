class LoginController < ApplicationController
  get '/', authentication: false do
    slim :'login/login'
  end

  post '/', authentication: false do
    user = User.find_by_email(params[:email])
    if user and user.password == params[:password]
      session[:user] = {id: user.id, email: user.email}
    end

    redirect '/day' if authenticated?

    redirect '/'
  end
end
