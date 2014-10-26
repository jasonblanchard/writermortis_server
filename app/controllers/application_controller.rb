class ApplicationController < ActionController::API
  include Pundit

  before_filter :authenticate_user_from_token!
  after_filter :cors_set_access_control_headers, :if => :in_dev
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def authenticate_user_from_token!
    user_token = params[:user_token].presence
    user_email = params[:user_email].presence
    user = user_email && User.find_by_email(user_email)

    if user && Devise.secure_compare(user.authentication_token, user_token)
      sign_in user, store: false
    end
  end

  # Fix respond_to error
  # https://github.com/rails-api/rails-api/issues/24
  def self.mimes_for_respond_to
    [1]
  end

  def user_not_authorized
    render :json => { :user => "Not Authorized" }, :status => 401
  end

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin']      = '*'
    headers['Access-Control-Allow-Methods']     = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age']           = '1728000'
    headers['Access-Control-Allow-Credentials'] = 'true'
  end

  def in_dev
    Rails.env == "development"
  end

end
