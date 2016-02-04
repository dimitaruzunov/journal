module ApplicationHelpers
  def authenticated?
    session[:user]
  end
end
