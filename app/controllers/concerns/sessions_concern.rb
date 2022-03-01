module SessionsConcern
    extend ActiveSupport::Concern
  
    included do
      helper_method :set_session_params
      helper_method :clear_session_params
    end
  
    def set_session_params(user)
        session[:user_id] = user.id
        session[:admin] = user.is_admin
        session[:org_color] = Organization.where(id: user.organization_id).pluck("color").first
    end
    
    def clear_session_params
        session.delete(:user_id)
        session.delete(:admin)
        session.delete(:org_color)
    end
  end