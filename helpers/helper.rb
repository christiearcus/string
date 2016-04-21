helpers do

  def current_user
    User.find_by(id: session[:user_id])
    # returns logged in user object
  end

  def logged_in?
     !!current_user
     # returns true if logged in
  end

  def find_trip
    Trip.find_by(id: params[:id])
    # returns trip object
  end

  def find_user_trips
    Trip.where(user_id: current_user.id)
    # finds all user trips
  end

  def sign_up_user
    user = User.new
    user.first_name = params[:firstname]
    user.last_name = params[:lastname]
    user.password = params[:password]
    user.email_address = params[:email]
      if user.valid?
        user.save
        #find in database (don't yet have current_user)
        new_user = User.find_by(email_address: params[:email])
        #set session id for the helper method.
        session[:user_id] = new_user.id
        redirect to "/trips/#{current_user.id}"
      else
        redirect to '/session/sign-up'
      end
  end

  def new_trip
    trip = Trip.new
    trip.name = params[:tripname]
    trip.trip_start = params[:start]
    trip.trip_end = params[:end]
    trip.duration = params[:duration]
    trip.og_budget = params[:budget]
    trip.budget = params[:budget]
    trip.user_id = current_user.id
    trip.save
      return trip.id
  end

#not finished yet.
  def trip_detail
    @trip_object = find_trip

    #find financial details
    @balance = @trip_object.budget # => 5,000
    @total_budget = @trip_object.og_budget # => 20,000

    #find time stuff
    @day_of_trip = @trip_object.trip_end - Time.now
    @day_of_trip = @day_of_trip / 60 / 60 / 24 # => 30 days

    #push all in to an object & return.
    return
  end

  def edit_trip
    trip_edit = find_trip
    trip_edit.name = params[:name]
    trip_edit.trip_start = params[:start]
    trip_edit.trip_end = params[:end]
    trip_edit.budget = params[:budget]
    trip_edit.save
      return trip_edit.id
  end

  def delete_trip
    trip_delete = find_trip
    trip_delete.destroy
  end

  def log_expense
    # log expense to database
    expense = Expense.new
    @trip_detail = find_trip
    expense.trip_id = @trip_detail.id
    expense.user_id = current_user.id
    expense.amount = params[:amount]
    expense.description = params[:note]
    expense.new_budget_amount = @trip_detail.budget - params[:amount].to_i
    expense.save

    #deduct from master trip total
    update = Trip.find_by(id: @trip_detail.id)
    update.budget = update.budget - expense.amount
    update.save
  end

end
