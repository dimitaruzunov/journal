module ApplicationHelpers
  def authenticated?
    session[:user]
  end

  def authenticate(user)
    session[:user] = {id: user.id, email: user.email}
    redirect '/day' if authenticated?

    redirect '/'
  end

  def user_email
    session[:user][:email] if authenticated?
  end

  def user_id
    session[:user][:id] if authenticated?
  end

  def partial(template, options = {})
    slim template, options
  end
end
