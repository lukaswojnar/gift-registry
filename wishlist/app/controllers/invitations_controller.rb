class InvitationsController < ApplicationController
  before_filter :validate_email, :only => [:create]

  def new
    @list = List.find params[:list_id]
  end

  def create
    email = params[:email]
    succ = false
    @user = User.find_by email: email
    @invitation = Invitation.new
    @invitation.list_id = params[:list_id]
    if @user
      if @user.id == current_user.id
        flash[:notice] = "It is not possible to send invitation to yourself."
      else
        @invitation.invited_user_id = @user.id
        uid = @user.id
        @invitation.save
        NotificationMailer.invitation_email_registered_user(@user, @invitation)
        flash[:success] = "Your invitation has been sent." 
        succ = true
      end
    else
      uid = User.invite!(:email => email).id
      @invitation.invited_user_id = uid
      @invitation.save
      flash[:success] = "Your invitation has been sent."
      succ = true
    end
    if succ
      @permission = Permission.new
      @permission.created_at= DateTime.now
      @permission.user_id = uid
      @permission.list_id = @invitation.list_id
      @permission.role = 1
      @permission.save
    end
    redirect_to controller: 'lists', action: 'index'
  end

  def my_invitations
    @invitations = current_user.invitations
  end

  def accept_invitation_on_event
    @invitation = Invitation.find params[:invitation_id]
    @list = List.find(@invitation.list_id)
    if list_participant?(@list)
      @invitation.status = 1
      @invitation.save
      flash[:notice] = "You accepted the invitation."
      redirect_to(:back)
    else
      redirect_to controller: 'lists', action: 'index'
      flash[:notice] = "You have to be participant on this event if you want accept invitation."
    end
  end

  def decline_invitation_on_event
    @invitation = Invitation.find params[:invitation_id]
    @invitation.status = 0
    self.remove_assigned_gifts(@invitation)
    @invitation.save
    flash[:notice] = "You declined the invitation."
    redirect_to(:back)
  end

  def validate_email
    if params[:email].nil?
      redirect_to new_list_invitation_path, notice: 'Enter some email!'
    end
  end

  def remove_assigned_gifts(invitation)
    @invitation = invitation
    @gifts = Gift.where(list_id: @invitation.list_id, assigned_user_id: current_user.id)
    @gifts.each do |g|
      g.assigned_user_id = nil
      g.save
    end
  end

end
