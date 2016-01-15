# Controller for create, update and delete gifts
class GiftController < ApplicationController

  def index
    @gifts = Gift.all
  end

  def new
    @gift = Gift.new
  end

  def edit
    @gift = Gift.find(params[:id])
  end

  def show
    @gift = Gift.find(params[:id])
  end

  def create
    @gift = Gift.new(gift_params)

    if @gift.save
      redirect_to @gift
    else
      render 'new'
    end
  end

  def update
    @gift = Gift.find(params[:id])

    if @gift.update(gift_params)
      redirect_to @gift
    else
      render 'edit'
    end
  end

  def destroy
    @gift = Gift.find(params[:id])
    @gift.destroy

    redirect_to gift_path
  end

  private
  def gift_params
    params.require(:gift).permit(:title, :description, :price, :link)
  end
end
