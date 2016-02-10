class ApplicationController < Sinatra::Base
  helpers ApplicationHelpers

  set :views, File.expand_path('../../views', __FILE__)
  set :public_folder, File.expand_path('../../../public', __FILE__)

  set :auth do |should_be_authenticated|
    condition do
      if should_be_authenticated
        redirect '/login' if not authenticated?
      else
        redirect '/' if authenticated?
      end

      true
    end
  end

  enable :sessions
  enable :method_override

  get '/' do
    redirect '/day' if authenticated?

    slim :index
  end
end
