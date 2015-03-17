class Auth::TokenAuthenticator
  def initialize(user)
    @user = user
  end

  def regenerate!
    clear_token = "#{@user.id}#{Devise.friendly_token}"
    encrypted_token = BCrypt::Password.create(clear_token, :cost => 5)
    @user.update_attributes!(:authentication_token => encrypted_token)
    clear_token
  end

  def valid?(input_token)
    bcrypt = BCrypt::Password.new(@user.authentication_token)
    encrypted_input_token = BCrypt::Engine.hash_secret(input_token, bcrypt.salt)
    Devise.secure_compare(encrypted_input_token, @user.authentication_token)
  end
end
