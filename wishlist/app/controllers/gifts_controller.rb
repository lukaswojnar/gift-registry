class GiftsController < ApplicationController
  def new
    @gift = Gift.new
    @list = List.find params[:list_id]
  end

  def create
    @gift = Gift.new(gift_params)
    @gift.list_id = params[:list_id]
    @gift.save
    redirect_to '/'
  end

  def index
    @gifts = Gift.where(:list_id => params[:list_id])
  end

  private
     def gift_params
       params.require(:gift).permit(:title, :description)
     end

end
