class ApplicationController < ActionController::Base
  before_filter :require_login
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def current_role
    return @current_user.role if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
    @current_user.role
  end

  helper_method :current_user_session, :current_user, :current_role


  private

  def require_login
      unless current_user
        redirect_to sign_in_path
      end
  end
end