helpers do
  def authenticate
    user = User.find_by(username: params[:user][:username])
    if user && user.password == params[:user][:password]
      create_session(user)
      return true
    end
  end

  def create_session(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
    # object if exists, nil if not, !! returns a forced boolean
  end

end
