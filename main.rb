require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require './db_config'
require './models/user'

enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
     !!current_user
  end
end

get '/' do
  erb :index
end

get '/session/new' do
  erb :login
end

post '/session/new' do
  user = User.find_by(email_address: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/trips'
    else
      erb :login
    end
end

delete '/session/logout' do
  session[:user_id] = nil
  redirect to '/'
end

get '/sign-up' do
  erb :signup
end

post '/sign-up' do
  user = User.new
  user.first_name = params[:firstname]
  user.last_name = params[:lastname]
  user.email_address = params[:email]
  user.password = params[:password]
  user.save
  redirect to '/trips'
end

get '/trips' do
  erb :trips
end

get '/new' do
  erb :new
end

# will eventually be :id
get '/detail' do
  erb :detail
end

get '/edit' do
  erb :edit
end
