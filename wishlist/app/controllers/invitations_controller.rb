class InvitationsController < ApplicationController
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
      @invitation.invited_user_id = User.invite!(:email => email)
    end
    @invitation.save
    redirect_to controller: 'lists', action: 'index'
  end

  def my_invivations
    @invitations = current_user.invitations
  end

end
