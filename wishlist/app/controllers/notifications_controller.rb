class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications
    @invitations = current_user.invitations
  end

  def new
    @list = List.find params[:list_id]
    if list_participant?(@list)
      @invitation = Invitation.find_by(list_id: @list.id, invited_user_id: current_user.id)
      if @invitation.status == false 
        flash[:notice] = "You have to accept the invitation when you want to create notification."
        redirect_to(:my_invitations)
      end
      @notification = Notification.new
    else
      redirect_to controller: 'lists', action: 'index'
      flash[:notice] = "You have to be participant on this event if you want to create notification."
    end
  end

  def create
    @list = List.find params[:notification][:list_id]
    if list_participant?(@list)
      @notification = Notification.new(notification_params)
      @notification.user_id = current_user.id
      @notification.list_id = @list.id

      if @notification.date > @list.event_date
        flash[:notice] = "Notification cannot be set after date of event."
        redirect_to(:my_notifications)
      else
        if @notification.save
          flash[:success] = "Notification has been created."
          redirect_to(:my_notifications)
        else
          render 'new'
        end
      end
    else
      redirect_to controller: 'lists', action: 'index'
      flash[:notice] = "You have to be participant on this event if you want to create notification."
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    flash[:notice] = "Notification has been deleted."
    redirect_to(:my_notifications)
  end

  private
  def notification_params
    params.require(:notification).permit(:date)
  end

  # do we need Update? user just can create and delete notification.

  #class method for notifiyng users?
  def self.notify
    @all_notifications = Notification.all

    @all_notifications.each do |notf|
      if notf.date.today?
        @user = User.find notf.user
        NotificationMailer.notification_email(@user, notf).deliver!
        notf.destroy
      end
    end


  end

end
