class RegisterController < ApplicationController
  get '/', auth: false do
    slim :'register/index'
  end

  post '/', auth: false do
    user = User.create(email: params[:email], password: params[:password])
    authenticate user if user.valid?

    redirect to '/'
  end
end
