require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require './db_config'
require './models/user'
require './models/trip'

enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user_id])
    # => returns whole user object (not just id)
  end

  def logged_in?
     !!current_user
     # => returns true if logged in
  end

  def find_trip
    Trip.find_by(id: params[:id])
    # => returns trip id
  end

  def find_user_trips
    Trip.where(user_id: current_user.id)
    # => finds all user trips
  end

end

get '/' do
  if logged_in?
   @trips = find_user_trips
   redirect to "/trips/#{current_user.id}"
    erb :trips
  else
    erb :index
  end
end

get '/session/new' do
  erb :login
end

#existing user login
post '/session/new' do
  user = User.find_by(email_address: params[:email])
    if user && user.authenticate(params[:password])
      #this sets the session id - which the helper method uses.
      session[:user_id] = user.id
      redirect to "/trips/#{current_user.id}"
    else
      erb :login
    end
end

#new user sign-up
post '/sign-up' do
  user = User.new
  user.first_name = params[:firstname]
  user.last_name = params[:lastname]
  user.email_address = params[:email]
  user.password = params[:password]
  user.save
  #find in database (don't yet have current_user)
  new_user = User.find_by(email_address: params[:email])
  #set session id for the helper method.
  session[:user_id] = new_user.id
  redirect to "/trips/#{current_user.id}"
end

#user's trips homepage.
get "/trips/:id" do
  @trips = find_user_trips
  erb :trips
end

get '/new' do
    erb :new
end

post '/new' do
  trip = Trip.new
  trip.name = params[:tripname]
  trip.trip_start = params[:start]
  trip.trip_end = params[:end]
  trip.budget = params[:budget]
  trip.user_id = current_user.id
  trip.save
  redirect to "/detail/#{trip.id}"
end

delete '/session/logout' do
  session[:user_id] = nil
  redirect to '/'
end

get '/sign-up' do
  erb :signup
end

get '/detail/:id' do
  @trip_detail = find_trip
  erb :detail
end

get '/edit/:id' do
  @trip_edit = find_trip
  erb :edit
end

put '/edit/:id' do
  @trip_edit = find_trip
  @trip_edit.trip_start = params[:start]
  @trip_edit.trip_end = params[:end]
  @trip_edit.budget = params[:budget]
  @trip_edit.save

  redirect to "/detail/#{@trip_edit.id}"
end

delete '/delete/:id' do
  @trip_delete = find_trip
  @trip_delete.destroy
  redirect to "/trips/#{session[:user_id]}"
end
