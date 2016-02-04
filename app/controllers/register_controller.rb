class RegisterController < ApplicationController
  get '/' do
    redirect to '../' if authenticated?

    slim :'register/register'
  end

  post '/' do
    redirect to '../' if authenticated?

    user = User.create(email: params[:email], password: params[:password])
    redirect to '../' if user.valid?

    redirect to '/'
  end
end
