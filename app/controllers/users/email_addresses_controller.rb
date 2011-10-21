class Users::EmailAddressesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @emails = @user.email_addresses

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @emails }
    end
  end

end
