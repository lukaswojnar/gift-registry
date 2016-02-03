class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def list_owner?(list)
    @list = list
    per = Permission.find_by(user_id: current_user.id, list_id: @list.id)
    if per
      per.role == 0 ? true : false
    else
      false
    end
  end

  def list_participant?(list)
    @list = list
    per = Permission.find_by(user_id: current_user.id, list_id: @list.id)
    if per
      per.role == 1 ? true : false
    else
      false
    end
  end

end
