class SessionsController < ApplicationController
  def login
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
      session[:admin] = @user.is_admin
      session[:org_color] = Organization.where(id: @user.organization_id).pluck("color").first
      redirect_to listings_path
    else
      flash[:error] = "Incorrect email or password."
      render :login, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    session.delete(:admin)
    session.delete(:org_color)
    redirect_to root_path
  end
end
