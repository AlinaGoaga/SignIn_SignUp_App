ENV['RACK_ENV'] = 'development'

require 'sinatra/base'
require './config/data_mapper'

class UserAuth < Sinatra::Base
  enable :sessions
  enable :method_override

  get '/' do
    @error_message = session[:error_message]
    session[:error_message] = nil
    erb :index
  end

  get '/profile' do
    if signed_in?
      erb :profile
    else
      redirect 'signin'
    end
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    redirect '/password_error' if params[:password].length < 7
    user = User.create(email: params[:email], password: params[:password])
    if user.valid?
      session[:user_id] = user.id
      redirect '/profile'
    else
      session[:error_message] = 'Sorry, that email address is taken'
      redirect '/'
    end
  end

  get '/password_error' do
    erb :password_error
  end

  get '/signin' do
    erb :signin
  end

  post '/signin' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/profile'
    else
      redirect '/'
    end
  end

  delete '/sessions' do
    session.delete(:user_id)
    redirect '/'
  end

  private

  def signed_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= User.get(session[:user_id])
  end
end
