class LoginController < ApplicationController
  get '/', authentication: false do
    slim :'login/login'
  end

  post '/', authentication: false do
    user = User.find_by_email(params[:email])
    authenticate user if user and user.password == params[:password]

    redirect to '/'
  end
end
