class RegistrationsController < Devise::RegistrationsController

  include ActionController::MimeResponds
  include ActionController::ImplicitRender

  def create
    @user = User.new(user_params)

    if @user.save
      render :json => @user
    else
      render :json => {:errors => @user.errors}, :status => 422
    end
  end

  private

  def user_params
    params.require(:registration).permit(:email, :username, :password, :password_confirmation)
  end
end
