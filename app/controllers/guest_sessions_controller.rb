class GuestSessionsController < ApplicationController
  def create
    user = User.guest
    start_new_session_for(user)
    redirect_to user_path(user), notice: "ログインしました"
  end
end