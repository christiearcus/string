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
    user.email_address = params[:email]
    user.password = params[:password]
    user.save
  end

  def new_trip
    trip = Trip.new
    trip.name = params[:tripname]
    trip.trip_start = params[:start]
    trip.trip_end = params[:end]
    trip.duration = params[:duration]
    trip.budget = params[:budget]
    trip.user_id = current_user.id
    trip.save
      return trip.id
  end

  def edit_trip
    trip_edit = find_trip
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

end
