class GiftsController < ApplicationController
  before_action :authenticate_user!

  def new
    @gift = Gift.new
    @list = List.find params[:list_id]
    if !list_owner?(@list)
      redirect_to controller: 'lists', action: 'index'
      flash[:notice] = "You don't have permisson to add gift to this list."
    end
  end

  def create
    @list = List.find params[:list_id]
    if list_owner?(@list)
      @gift = Gift.new(gift_params)
      @gift.list_id = @list.id
      @gift.save
      redirect_to controller: 'gifts', action: 'index'
      flash[:notice] = "Gift successfully created."
    else
      redirect_to controller: 'lists', action: 'index'
      flash[:notice] = "You don't have permisson to add gift to this list."
    end
  end

  def index
    @gift = Gift.new
    @gifts = Gift.where(:list_id => params[:list_id])
    @list = List.find params[:list_id]
    if !list_owner?(@list)
      redirect_to controller: 'lists', action: 'index'
      flash[:notice] = "You don't have permisson to manage this list."
    end
  end

  def edit
    @gift = Gift.find(params[:id])
    @list = List.find(@gift.list_id)
    if list_owner?(@list)
      if @gift.assigned_user_id
        redirect_to(:back)
        flash[:notice] = "Some user has chosen this gift. It is not possible to edit it now."
      end
    else
      redirect_to controller: 'lists', action: 'index'
      flash[:notice] = "You do not have permisson edit this gift."
    end
  end

  def gifts_to_buy
    @gifts = Gift.where(assigned_user_id: current_user.id).order(:list_id, :title)
  end

  def update
    @gift = Gift.find(params[:id])
    @list = List.find(@gift.list_id)
    if list_owner?(@list)
      if @gift.update_attributes(gift_params)
        redirect_to controller: 'gifts', action: 'index'
        flash[:notice] = "Gift successfully saved."
      else
        render 'edit'
      end
    else
      redirect_to controller: 'lists', action: 'index'
      flash[:notice] = "You do not have permisson edit this gift."
    end
  end

  def destroy
    @gift = Gift.find(params[:id])
    @list = List.find(@gift.list_id)
    if list_owner?(@list)
      @gift.destroy
      redirect_to controller: 'gifts', action: 'index'
      flash[:success] = "Gift successfully deleted."
    else
      redirect_to controller: 'lists', action: 'index'
      flash[:notice] = "You do not have permisson destroy this gift."
    end
  end

  def take_gift
    @gift = Gift.find(params[:id])
    @list = List.find(@gift.list_id)
    if list_participant?(@list)
      if @gift.assigned_user_id.blank?
        @gift.assigned_user_id = current_user.id
        @gift.save
        flash[:success] = "You will buy this gift."
        redirect_to(:back)
      else
        flash[:notice] = "Gift is taken by another user."
        redirect_to(:back)
      end
    else
      redirect_to controller: 'lists', action: 'index'
      flash[:notice] = "You have to be participant on this event if you want to buy this gift."
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
      flash[:notice] = "Something went wrong."
      redirect_to(:back)
    end
  end

  private
     def gift_params
       params.require(:gift).permit(:title, :description, :link, :price, :image)
     end

end
