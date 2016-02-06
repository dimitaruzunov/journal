module ApplicationHelpers
  def authenticated?
    session[:user]
  end

  def user_email
    session[:user][:email] if authenticated?
  end

  def partial(template, options = {})
    slim template, options
  end
end
