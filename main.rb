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

post '/session/logout' do
  session[:user_id] = nil
  redirect to '/'
end

get '/session/sign-up' do
  erb :signup
end

get '/detail/:id' do
  @trip_detail = find_trip
  @daily_budget = @trip_detail.budget / @trip_detail.duration
  erb :detail
end

get '/detail/:id/newexpense' do
  @trip_detail = find_trip
  erb :expense
end


post '/detail/:id/newexpense' do
  @trip_detail = find_trip
  trip_user = current_user

  #create new expense for trip (for trip's first expense)
  expense = Expense.new
  expense.trip_id = @trip_detail.id
  expense.user_id = current_user.id
  expense.amount = params[:amount]
  expense.description = params[:note]
  expense.new_budget_amount = @trip_detail.budget - params[:amount].to_i
  expense.save

  #deduct from trip budget
  update = Trip.find_by(id: @trip_detail.id)
  update.budget = update.budget - expense.amount
  update.save

  #need subsequent expense
  redirect to '/'
end

get '/edit/:id' do
  @trip_edit = find_trip
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
