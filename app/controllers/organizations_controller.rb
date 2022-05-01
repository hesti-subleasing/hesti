
class OrganizationsController < ApplicationController
  # shows organization profile that only admins can access
  def organization
    if session[:user_id]
      id = session[:user_id]
      @user = User.find(id)
      if !@user.is_admin
        redirect_to profile_path
      end

      @org = Organization.find(@user.organization_id)
    else
      flash[:warning] = "You must log in to view organization."
      redirect_to login_path
    end
  end
  
  # edit organization settings
  def edit
    if session[:user_id]
      @user = User.find(session[:user_id])
      p @user
      if !@user.is_admin and @user.organization_id != params[:id]
        redirect_to profile_path
      end
      @org = Organization.find(params[:id])
    else
      flash[:warning] = "You must log in to edit organization."
      redirect_to login_path
    end
    
  end

  # updates organization settings based on edit form
  def update
    @org = Organization.find(params[:id])
    @org.update!(org_params)
    session[:org_color] = @org.color
    redirect_to organization_path
  end

  # shows the admin the people who are part of the org
  def users
    if session[:user_id]
      id = session[:user_id]
      @user = User.find(id)
      if !@user.is_admin
        redirect_to profile_path
      end

      # ppl who are part of the org
      @members = User.where(organization_id: @user.organization_id).order("id").pluck("id", "first_name", "last_name", "username", "email")
      @org = Organization.find(@user.organization_id)
    else
      flash[:warning] = "You must log in to view users."
      redirect_to login_path
    end
  end

  def org_params
    params.require(:organization).permit(:name, :color)
  end
end
