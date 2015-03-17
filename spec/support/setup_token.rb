def token_auth_for(user)
  authenticator = Auth::TokenAuthenticator.new(user)
  token = authenticator.regenerate!
  { :user_email => user.email, :user_token => token }
end
