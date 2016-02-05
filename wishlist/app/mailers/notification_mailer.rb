class NotificationMailer < ApplicationMailer
  default from: 'notifications@gift-registry.herokuapp.com'
  
  def notification_email(user, notf)
    @user = user
    @notification = notf
    @gifts = Gift.where(list_id: @notification.list.id, assigned_user_id: @user.id)
    mail(to: @user.email, subject: 'Your event will be soon!')
  end

  def invitation_email_registered_user(user, inv)
    @user = user
    @invitation = inv
    mail(to: @user.email, subject: 'Your have been invited to an event!')
  end

end
