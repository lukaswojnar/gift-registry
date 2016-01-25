class WelcomeController < ApplicationController
  def index
  end

  def search
    redirect_to '/search/'+params[:query]
  end

end
