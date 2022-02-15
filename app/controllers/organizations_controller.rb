
class OrganizationsController < ApplicationController
  def organization
    if session[:user_id]
      id = session[:user_id]
      @user = User.find(id)
      if !@user.is_admin
        redirect_to profile_path
      end
      
      # if @user.organization_id != params[:id].to_i
      #   redirect_to root_path
      #   return
      # end

      # ppl who are part of the org
      @members = User.where(organization_id: @user.organization_id).pluck("username")
      @org = Organization.find(@user.organization_id)
    else
      redirect_to login_path
    end
  end
  
  def edit
    if session[:user_id]
      @user = User.find(session[:user_id])
      if !@user.is_admin
        redirect_to profile_path
      end
      
      @org = Organization.find(params[:id])
    else
      redirect_to login_path
    end
    
  end

  def update
    @org = Organization.find(params[:id])
    @org.update!(org_params)
    session[:org_color] = @org.color
    redirect_to organization_path
  end

  def org_params
    params.require(:organization).permit(:name, :color)
  end
end
