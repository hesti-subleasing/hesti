class UsersController < ApplicationController
  helper_method :errors_for

  def home
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  
  # helper functions

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
  end
end
