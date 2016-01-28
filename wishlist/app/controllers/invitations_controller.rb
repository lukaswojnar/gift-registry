class InvitationsController < ApplicationController
  before_filter :validate_email, :only => [:create]

  def new
    @list = List.find params[:list_id]
  end

  def create
    email = params[:email]
    @user = User.find_by email: email
    @invitation = Invitation.new
    @invitation.list_id = params[:list_id]
    if @user
      @invitation.invited_user_id = @user.id
    else
      @invitation.invited_user_id = User.invite!(:email => email).id
    end
    @invitation.save
    flash[:success] = "Your invitation has been sent."
    redirect_to controller: 'lists', action: 'index'
  end

  def my_invitations
    @invitations = current_user.invitations
  end

  def accept_invitation
    @invitation = Invitation.find params[:invitation_id]
    @invitation.status = 1
    @invitation.save
    flash[:notice] = "You accepted the invitation."
    redirect_to(:back)
  end

  def decline_invitation
    @invitation = Invitation.find params[:invitation_id]
    @invitation.status = 0
    @invitation.save
    flash[:notice] = "You declined the invitation."
    redirect_to(:back)
  end

  def validate_email
    if params[:email].nil?
      redirect_to new_list_invitation_path, notice: 'Enter some email!'
    end
  end

end
