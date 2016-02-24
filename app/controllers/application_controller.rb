class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in?

  def sign_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if user_signed_in?
  end
  helper_method :current_user

  def authenticate_user
    redirect_to new_session_path, notice: "Please sign in" unless user_signed_in?
  end

  rescue_from CanCan::AccessDenied do |exception|

    exception.default_message = "Default error message"
    redirect_to root_path, :alert => exception.message
  end

  def is_author_of? (model, user=current_user)
    if model.has_attribute? :user_id
      model.user_id == current_user.id ? true : false
    else
      false
    end
  end
  helper_method :is_author_of?
end
