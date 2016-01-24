class GiftsController < ApplicationController
  def new
    @gift = Gift.new
    @list = List.find params[:list_id]
  end

  def create
    @gift = Gift.new(gift_params)
    @gift.list_id = params[:list_id]
    @gift.save
    redirect_to controller: 'gifts', action: 'index'
  end

  def index
    @gifts = Gift.where(:list_id => params[:list_id])
    @list = List.find params[:list_id]
  end

  def edit
    @gift = Gift.find(params[:id])
    @list = List.find params[:list_id]
  end

  def update
    @gift = Gift.find(params[:id])
    if @gift.update_attributes(gift_params)
      redirect_to controller: 'gifts', action: 'index'
    else
      render 'edit'
    end
  end

  def destroy
    @gift = Gift.find(params[:id])
    @gift.destroy

    redirect_to controller: 'gifts', action: 'index'
  end

  private
     def gift_params
       params.require(:gift).permit(:title, :description, :link, :price, :assigned_to)
     end

end
