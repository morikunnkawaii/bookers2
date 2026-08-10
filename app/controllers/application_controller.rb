class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  private

  def after_authentication_url
    user_path(Current.user.id)#user showへ
  end

  def after_logout_url
    flash[:notice] = "Signed out successfully"
    root_path
  end
end
