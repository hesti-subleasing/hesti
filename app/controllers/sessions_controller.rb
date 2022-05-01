class SessionsController < ApplicationController
  include SessionsConcern

  def login
  end

  # login user
  def create
    @user = User.find_by(email: params[:email])

    # checking user credentials
    if @user && @user.password == params[:password]
      set_session_params(@user)

      redirect_to listings_path
    else
      flash[:warning] = "Incorrect email or password."
      render :login, status: :unprocessable_entity
    end 
  end

  def login_sso
    if user = authenticate_with_google        
      set_session_params(user)

      redirect_to listings_path
    else
      redirect_to root_path, alert: 'authentication_failed'
    end    

  end

  def destroy
    clear_session_params
    redirect_to root_path
  end

  private
    def authenticate_with_google
      if id_token = flash[:google_sign_in][:id_token]
        # google auth worked
        google = GoogleSignIn::Identity.new(id_token)

        if user = User.find_by(google_id: google.user_id)
          # return existing user
          return user

        else
          # create new user with google info
          return new_google_user(google)
        end

      elsif error = flash[:google_sign_in][:error]
        # google auth failed
        logger.error "Google authentication error: #{error}"
        nil
      end
    end
    
    def new_google_user(google)
      # fill user params with info from google auth
      user_params = {first_name: google.given_name, last_name: google.family_name,
                     password: "test", email: google.email_address,
                     username: make_username(google),
                     google_id: google.user_id}

      # set organization if valid
      if org = get_org(google.hosted_domain)
        user_params[:organization_id] = org.id
      end

      user = User.new(user_params)
      if user.save
        return user
      end

      return nil
    end

    def make_username(google)
      # append number to username if similar username(s) exist
      similar_usernames = User.where('username ~ ?', "^#{google.given_name}_#{google.family_name}").pluck("username")
      username_num = similar_usernames.any? ? 1 : ""
      similar_usernames.each do |username|
        if /(?<num_appended>\d+)$/ =~ username
          username_num = [username_num, num_appended.to_i+1].max
        end
      end

      return "#{google.given_name}_#{google.family_name}#{username_num}"
    end

    # returns organization for domain (or nil if doesn't exist)
    def get_org(domain)
      org_name = ""
      if domain == "tamu.edu"
        org_name = "TAMU"
      elsif domain == "g.austincc.edu"
        org_name = "AUSTINCC"
      elsif domain == "rice.edu"
        org_name = "RICE"
      end

      return Organization.find_by(name: org_name)
    end
end
