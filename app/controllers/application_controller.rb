class ApplicationController < ActionController::API
  include Pundit

  before_filter :authenticate_user_from_token!
  after_filter :cors_set_access_control_headers, :if => :in_dev
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def handle_options_request
    head(:ok) if request.request_method == "OPTIONS"
  end

  private

  def authenticate_user_from_token!
    auth_header = request.headers["Authorization"] || ''
    # TODO Can we remove check for token in params?
    user_token = auth_header[/token="([\w\d-]+)/,1] || params[:user_token].presence
    user_email = auth_header[/email="(.+)"/,1] || params[:user_email].presence
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
    headers['Access-Control-Allow-Methods']     = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Max-Age']           = '1728000'
    headers['Access-Control-Allow-Credentials'] = 'true'
    headers['Access-Control-Allow-Headers']     = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end

  def in_dev
    Rails.env == "development"
  end

end
