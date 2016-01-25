class GiftsController < ApplicationController
  before_action :authenticate_user!, :except => [:search, :assign]

  def new
    @gift = Gift.new
    @list = List.find params[:list_id]
    authorize! :read, @list
  end

  def create
    @gift = Gift.new(gift_params)
    @gift.list_id = params[:list_id]
    @gift.save
    redirect_to controller: 'gifts', action: 'index'
  end

  def index
    @gift = Gift.new
    @gifts = Gift.where(:list_id => params[:list_id])
    @list = List.find params[:list_id]
    authorize! :read, @list
  end

  def edit
    @gift = Gift.find(params[:id])
    @list = List.find params[:list_id]
    authorize! :edit, @gift
  end

  def update
    @gift = Gift.find(params[:id])
    authorize! :update, @gift
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

  def search
    l = List.find_by share_code: params[:id]
    unless l.blank?
      @gifts = Gift.where(:list_id => l)
      @list = l
    else
      redirect_to controller: 'welcome', action: 'index'
    end
  end

  def assign
    @gift = Gift.find(params[:gift_id])
    if @gift.update_attributes(assigned_to: params[:assigned_to])
      redirect_to(:back)
    else
      redirect_to(:back)
    end
  end

  private
     def gift_params
       params.require(:gift).permit(:title, :description, :link, :price, :assigned_to)
     end

end
