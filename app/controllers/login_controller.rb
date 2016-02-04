class LoginController < ApplicationController
  get '/' do
    redirect to '../' if authenticated?

    slim :'login/login'
  end

  post '/' do
    redirect to '../' if authenticated?

    redirect to '../' if authenticate(params[:email], params[:password])

    redirect to '/'
  end

  private

  def authenticate(email, password)
    user = User.find_by_email(email)
    session[:user] = user.id if user and user.password == password
  end
end
