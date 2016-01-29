class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications
  end

  def new
    @list = List.find params[:list_id]
    @notification = Notification.new
  end

  def create
    @list = List.find params[:list_id]
    @notification = Notification.new(notification_params)
    @notification.user_id = current_user.id
    @notification.list_id = @list.id

    if @notification.save
      flash[:success] = "Notification has been created."
      redirect_to controller: 'lists', action: 'index'
    else
      render 'new'
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    redirect_to lists_path
    flash[:notice] = "Notification has been deleted."
  end

  private
  def notification_params
    params.require(:notification).permit(:date)
  end

  # do we need Update? user just can create and delete notification.

end
