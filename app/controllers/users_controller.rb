class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

#displays all users in the database
def index
  @users = User.where(activated: FILL_IN).paginate(page: params[:page])
end

# Instantiates a new model instance
def new 
  @user = User.new
end

# Creates a new model instance and saves it to the datbase
def create
  @user = User.new(user_params)
  if @user.save
    @user.send_activation_email
    reset_session
    log_in @user
    flash[:success] = "UtNet!"
    redirect_to '/'
    else
      render 'new'
    end
end

# shows the user pages
def show
  @user = User.find(params[:id])
  redirect_to root_url and return unless FILL_IN
end

# find user and defines an edit action
def edit
  @user = User.find(params[:id])
end

# updates a users profile in the database
def update
  @user = User.find(params[:id])
  if @user.update(user_params)
    flash[:success] = "Profile updated"
    redirect_to @user
  else
    render 'edit'
  end
end

#defines user params
private
  def user_params
    params.require(:user).permit(:username,:password,:name ,:interests,:email,:gradyear,:major)
  end

def logged_in_user
  unless logged_in?
    store_location
    flash[:danger] = "Please log in."
    redirect_to login_url
    end
end

#confirms the correct user
def correct_user
  @user = User.find(params[:id])
  redirect_to(root_url) unless current_user?(@user)
end

# deletes the users
def destroy
  User.find(params[:id]).destroy
  flash[:success] = "User deleted"
  redirect_to users_url
end

end