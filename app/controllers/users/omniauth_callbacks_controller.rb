class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    handle_oauth :facebook
  end

  def cloudfoundry
    handle_oauth :cloudfoundry
  end

  def github
    handle_oauth :github
  end


  def handle_oauth provider
    if (env && env["omniauth.auth"] && env["omniauth.auth"]['credentials'])
       # Get email from external service the current user just authenticated with
      id = env["omniauth.auth"]['uid']

      @user = nil
      if (env["omniauth.auth"]['user_info']['email'])
        email = env["omniauth.auth"]['user_info']['email']
        id = email
        # Find a user with that email or return the current user
        @user = User.get_user_from_auth_by_email email, current_user
      end

      unless @user
        @user = User.get_user_from_auth_by_id provider, id, current_user
      end

      # Store the Access token under the email address or unique id
      ut = UserAccessToken.add_tokens email, id, provider, env["omniauth.auth"]['credentials']

      if @user && @user.persisted?
        # If the user already existed
        # Make sure the access token is pointing to the proper user
        ut.update_attribute :user_id, @user.id

        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => provider

        if (current_user != @user)
          flash[:notice] = "Switching logged in user to #{@user.display_name}"
        end
        sign_in_and_redirect @user, :event => :authentication
      else
        flash[:notice] = 'Please complete registration to App Gallery'

        # Persist the data
        session["devise.omniauth_info"] = env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    else
      flash[:notice] = 'Not enough information to sign in'
      redirect_to new_user_session_path
    end
  end

end