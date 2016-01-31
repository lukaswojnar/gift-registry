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
      if @user.id == current_user.id
        flash[:notice] = "It is not possible to send invitation to yourself."
      else
        @invitation.invited_user_id = @user.id
        @invitation.save
        flash[:success] = "Your invitation has been sent." 
      end
    else
      @invitation.invited_user_id = User.invite!(:email => email).id
      @invitation.save
      flash[:success] = "Your invitation has been sent."
    end
    redirect_to controller: 'lists', action: 'index'
  end

  def my_invitations
    @invitations = current_user.invitations
  end

  def accept_invitation_on_event
    @invitation = Invitation.find params[:invitation_id]
    @invitation.status = 1
    @invitation.save
    flash[:notice] = "You accepted the invitation."
    redirect_to(:back)
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
