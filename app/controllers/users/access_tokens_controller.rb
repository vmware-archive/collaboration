class Users::AccessTokensController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @tokens = UserAccessToken.access_tokens_for_user @user.id

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @tokens }
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @token = UserAccessToken.find(params[:id])
    if (@token.user_id == @user.id)
      @token.destroy
    end

    respond_to do |format|
      format.html { redirect_to(user_access_tokens_url(@user)) }
      format.json  { head :ok }
    end
  end

end
