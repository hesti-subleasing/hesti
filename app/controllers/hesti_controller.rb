class HestiController < ApplicationController
  helper_method :errors_for

  def home
  end

  def new_account
    @user = User.new
  end

  def create_account
    @user = User.new(user_params)

    puts "trying to create user"

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new_account
    end
  end

  def login
  end

  def login_auth
    @user = User.find_by(email: params[:email])

    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to login_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password)
  end
end
