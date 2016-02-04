module ApplicationHelpers
  def authenticated?
    session[:user]
  end

  def partial(template, options = {})
    slim template, options
  end
end
