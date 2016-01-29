class GiftsController < ApplicationController
  before_action :authenticate_user!

  def new
    @gift = Gift.new
    @list = List.find params[:list_id]
  end

  def create
    @gift = Gift.new(gift_params)
    @gift.list_id = params[:list_id]
    @gift.save
    redirect_to controller: 'gifts', action: 'index'
    flash[:notice] = "Gift successfully created."
  end

  def index
    @gift = Gift.new
    @gifts = Gift.where(:list_id => params[:list_id])
    @list = List.find params[:list_id]
  end

  def edit
    @gift = Gift.find(params[:id])
    if @gift.assigned_user_id
      redirect_to(:back)
      flash[:notice] = "Some user has chosen this gift. It is not possible to edit it now."
    end
    @list = List.find params[:list_id]
  end

  def update
    @gift = Gift.find(params[:id])
    if @gift.update_attributes(gift_params)
      redirect_to controller: 'gifts', action: 'index'
      flash[:notice] = "Gift successfully saved."
    else
      render 'edit'
    end
  end

  def destroy
    @gift = Gift.find(params[:id])
    @gift.destroy
    redirect_to controller: 'gifts', action: 'index'
    flash[:success] = "Gift successfully deleted."
  end

  def take_gift
    @gift = Gift.find(params[:id])
    if @gift.assigned_user_id.blank?
      @gift.assigned_user_id = current_user.id
      @gift.save
      flash[:success] = "You will buy this gift."
      redirect_to(:back)
    else
      flash[:notice] = "Gift is taken by another user."
      redirect_to(:back)
    end
  end

  def remove_assigned_gift
    @gift = Gift.find(params[:id])
    if @gift.assigned_user_id = current_user.id
      @gift.assigned_user_id = nil
      @gift.save
      flash[:success] = "Gift is not assigned to you. Other users can buy it."
      redirect_to(:back)
    else
      flash[:notice] = "Something went wrongs."
      redirect_to(:back)
    end
  end

  private
     def gift_params
       params.require(:gift).permit(:title, :description, :link, :price)
     end

end
