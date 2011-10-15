class HomeController < ApplicationController
  def index
    if session.has_key? :url_after_oauth
      redirect_to session[:url_after_oauth]
    end
  end

end
