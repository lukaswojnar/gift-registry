class ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @lists_future = current_user.lists.where('event_date > ?', DateTime.now).order(event_date: :desc)
    @lists_past = current_user.lists.where('event_date < ?', DateTime.now).order(event_date: :desc)
  end

  def show
    redirect_to controller: 'gifts', action: 'index', :list_id => params[:id]
  end

  def new
    @list = List.new
  end

  def edit
    @list = List.find(params[:id])
    if !list_owner?(@list)
      redirect_to controller: 'lists', action: 'index'
      flash[:notice] = "You do not have permisson edit this list."
    end
  end

  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    if @list.save
      flash[:success] = "List has been created."
      @permission = Permission.new
      @permission.created_at= DateTime.now
      @permission.user_id = current_user.id
      @permission.list_id = @list.id
      @permission.role = 0
      @permission.save
      redirect_to controller: 'lists', action: 'index'
    else
      render 'new'
    end
  end

  def update
    @list = List.find(params[:id])
    if list_owner?(@list)
      if @list.update(list_params)
        flash[:success] = "List has been saved."
        redirect_to @list
      else
        redirect_to controller: 'lists', action: 'index'
      end
    else
      redirect_to controller: 'lists', action: 'index'
      flash[:notice] = "You do not have permisson edit this list."
    end
  end

  def destroy
    @list = List.find(params[:id])
    if list_owner?(@list)
      @list.destroy
      redirect_to lists_path
      flash[:success] = "List has been deleted."
    else
      redirect_to lists_path
      flash[:notice] = "You don't have permission to destroy this list."
    end
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
