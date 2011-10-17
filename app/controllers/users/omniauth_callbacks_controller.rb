class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    handle_oauth :facebook
  end

  def cloudfoundry
    handle_oauth :cloudfoundry
  end


  def handle_oauth provider
    if (env && env["omniauth.auth"] && env["omniauth.auth"]['credentials'])
       # Get email from external service the current user just authenticated with
      email = env["omniauth.auth"]['user_info']['email']

      # Store the Access token under the email address
      ut = UserAccessToken.add_tokens email, provider, env["omniauth.auth"]['credentials']

      # Find a user with that email or return the current user
      @user = User.get_user_from_auth email, current_user

      if @user.persisted?
        # If the user already existed
        # Make sure the access token is pointing to the proper user
        ut.update_attribute :user_id, @user.id

        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => provider
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