class SessionsController < ApplicationController
  def login
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect_to listings_path
    else
      flash[:error] = "Incorrect email or password."
      render :login, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
