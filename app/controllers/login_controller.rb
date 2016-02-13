class LoginController < ApplicationController
  get '/', auth: false do
    slim :'login/index'
  end

  post '/', auth: false do
    user = User.find_by_email(params[:email])
    authenticate user if user and user.password == params[:password]

    redirect to '/'
  end
end
