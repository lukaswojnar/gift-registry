class ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @lists = current_user.lists
  end

  def show
    redirect_to controller: 'gifts', action: 'index', :list_id => params[:id]
  end

  def new
    @list = List.new
  end

  def edit
    @list = List.find(params[:id])
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id

    if @list.save
      flash[:success] = "List has been created."
      redirect_to controller: 'lists', action: 'index'
    else
      render 'new'
    end
  end

  def update
    @list = List.find(params[:id])

    if @list.update(list_params)
      flash[:success] = "List has been saved."
      redirect_to @list
    else
      render 'edit'
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to lists_path
    flash[:notice] = "List has been deleted."
  end

  def detail
    @list = List.find(params[:id])
    @gifts = Gift.where(list_id: @list.id)
    @my_invitation = Invitation.find_by(invited_user_id: current_user.id, list_id: @list.id)
    @participants = User.joins(:invitations).where(invitations: {status: true, list_id: @list.id})
    @nonparticipants = User.joins(:invitations).where(invitations: {status: false, list_id: @list.id})
    @invited_only = User.joins(:invitations).where(invitations: {status: nil, list_id: @list.id})
  end

  private
  def list_params
    params.require(:list).permit(:title, :description, :address, :event_date)
  end

end
