class ApplicationController < ActionController::API
  before_filter :authenticate_user_from_token!

  private

  def authenticate_user_from_token!
    user_token = params[:user_token].presence
    user_email = params[:user_email].presence
    user = user_email && User.find_by_email(user_email)

    if user && Devise.secure_compare(user.authentication_token, token)
      sign_in user, store: false
    end
  end

  # Fix respond_to error
  # https://github.com/rails-api/rails-api/issues/24
  def self.mimes_for_respond_to
    [1]
  end
end
