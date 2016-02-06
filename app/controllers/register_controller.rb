class RegisterController < ApplicationController
  get '/', authentication: false do
    slim :'register/register'
  end

  post '/', authentication: false do
    user = User.create(email: params[:email], password: params[:password])
    redirect '/login' if user.valid?

    redirect to '/'
  end
end
