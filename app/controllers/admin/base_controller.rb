class Admin::BaseController < ApplicationController

  layout 'admin_dashboard'

  before_action :authenticate_user!

  private

  # Check that the user is signed in as an admin before letting them in here
  def authenticate_user!
    if user_signed_in?
      unless current_user.admin?
        redirect_to root_path, notice: "You are not an admin."
      end
      super
    else
      redirect_to new_user_session_path, notice: "You must sign into an admin account to access this area."
    end
  end

end
