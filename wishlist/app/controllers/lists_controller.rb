class ListsController < ApplicationController

  def index
    @lists = current_user.lists
  end

  def show
    redirect_to controller: 'gifts', action: 'index', :list_id => params[:id]
  end

  def search
    l = List.find_by share_code: params[:query]
    unless l.blank?
      redirect_to controller: 'gifts', action: 'index', :list_id => l
    else
      redirect_to controller: 'welcome', action: 'index'
    end
  end

  def new
    @list = List.new
  end

  def edit
    @list = List.find(params[:id])
  end

  def create
    @list = List.new(list_params)
    @list.share_code = Digest::SHA1.hexdigest([Time.now, rand].join)
    @list.user_id = current_user.id

    if @list.save
      redirect_to controller: 'lists', action: 'index'
    else
      render 'new'
    end
  end

  def update
    @list = List.find(params[:id])

    if @list.update(list_params)
      redirect_to @list
    else
      render 'edit'
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy

    redirect_to lists_path
  end

  private
  def list_params
    params.require(:list).permit(:title, :text)
  end

end
