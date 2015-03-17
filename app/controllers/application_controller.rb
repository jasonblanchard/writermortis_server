class ApplicationController < ActionController::API
  include Pundit

  before_filter :authenticate_user_from_token!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def handle_options_request
    head(:ok) if request.request_method == "OPTIONS"
  end

  private

  def authenticate_user_from_token!
    auth_header = request.headers["Authorization"] || ''
    user_token = auth_header[/token="([\w\d-]+)/,1] || params[:user_token].presence
    user_email = auth_header[/email="(.+)"/,1] || params[:user_email].presence
    user = user_email && User.find_by_email(user_email)

    if user && Auth::TokenAuthenticator.new(user).valid?(user_token)
      sign_in user, store: false
    end
  end

  # Fix respond_to error
  # https://github.com/rails-api/rails-api/issues/24
  def self.mimes_for_respond_to
    [1]
  end

  def user_not_authorized
    render :json => {}, :status => 401
  end

end
