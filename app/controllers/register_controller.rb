class RegisterController < ApplicationController
  get '/' do
    slim :'register/register'
  end

  post '/' do
    email = params[:email]
    password = params[:password]

    user = User.create(email: email, password: password)
    redirect to '../' if user.valid?

    redirect to '/'
  end
end
