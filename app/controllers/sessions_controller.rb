class SessionsController < Devise::SessionsController

  include ActionController::MimeResponds
  include ActionController::ImplicitRender

  def create
    respond_to do |format|
      format.html { super }
      format.json do
        self.resource = warden.authenticate!(auth_options)
        sign_in(resource_name, resource)
        data = {
          token: Auth::TokenAuthenticator.new(self.resource).regenerate!,
          email: self.resource.email,
          user_id: self.resource.id
        }
        render json: data, status: 201
      end
    end
  end
end
