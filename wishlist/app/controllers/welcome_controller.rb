class WelcomeController < ApplicationController
  def index
  end

  def search
    if params[:query].blank?
      redirect_to(:back)
    else
      redirect_to '/search/'+params[:query]
    end
  end

end
