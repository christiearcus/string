require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require './db_config'
require './helpers/helper'
require './models/user'
require './models/trip'
require './models/expense'

enable :sessions

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

post '/sign-up' do
  #user sign up helper method
  sign_up_user
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
  #call new trip method, which returns trip.id
  trip = new_trip
  redirect to "/detail/#{trip}"
end

get '/session/logout' do
  session[:user_id] = nil
  redirect to '/'
end

get '/session/sign-up' do
  erb :signup
end

get '/detail/:id' do
  @trip_object = find_trip
  #find financial details
  @balance = @trip_object.budget # => 5,000
  @total_budget = @trip_object.og_budget # => 20,000
  #find time stuff
  @trip_length = @trip_object.trip_end - @trip_object.trip_start
  @trip_length = @trip_length / 60 / 60 / 24
  @days_left = @trip_object.trip_end - Time.now
  @days_left = @days_left / 60 / 60 / 24
  #daily amount
  @daily_amount = @balance / @days_left
  #present dates nicely
  @start = @trip_object.trip_start.strftime('%d %b %Y')
  @end = @trip_object.trip_end.strftime('%d %b %Y')
  erb :detail
end

get '/detail/:id/newexpense' do
  @trip_detail = find_trip
  erb :expense
end


post '/detail/:id/newexpense' do
  @trip_detail = find_trip
  log_expense
  redirect to "/detail/#{@trip_detail.id}"
end

get '/edit/:id' do
  @trip_edit = find_trip
  @start_parsed = @trip_edit.trip_start.strftime("%d/%m/%Y")
  @end_parsed = @trip_edit.trip_end.strftime("%d/%m/%Y")

  erb :edit
end

put '/edit/:id' do
  trip_edit = edit_trip
  redirect to "/detail/#{trip_edit}"
end

delete '/delete/:id' do
  delete_trip
  redirect to "/trips/#{session[:user_id]}"
end
