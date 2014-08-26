OmniAuth.config.logger = Rails.logger
OmniAuth.config.on_failure = SessionsController.action(:omniauth_failure)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, Rails.application.secrets.linkedin_key, Rails.application.secrets.linkedin_secret,
           # https://developer.linkedin.com/documents/profile-fields#profile
           scope: 'r_basicprofile',
           fields: %w(id email-address first-name last-name headline industry picture-url public-profile-url location)
end
