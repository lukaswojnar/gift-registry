class NotificationMailer < ApplicationMailer
  default from: 'notifications@example.com'
  
  def notification_email(user, notf)
    @user = user
    @notification = notf
    @gifts = Gift.where(list_id: @notification.list.id, assigned_user_id: @user.id)
    mail(to: @user.email, subject: 'Your event will be soon!')
  end
end
