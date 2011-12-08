require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if Rails.env.test?
  provider :github, APP_CONFIG.auth['github']['key'], APP_CONFIG.auth['github']['secret'] if APP_CONFIG.auth['github']
  provider :facebook, APP_CONFIG.auth['facebook']['key'], APP_CONFIG.auth['facebook']['secret'] if APP_CONFIG.auth['facebook']
  provider :twitter, APP_CONFIG.auth['twitter']['key'], APP_CONFIG.auth['twitter']['secret'] if APP_CONFIG.auth['twitter']
  provider :google_oauth2, APP_CONFIG.auth['google_oauth2']['key'], APP_CONFIG.auth['google_oauth2']['secret'] if APP_CONFIG.auth['google_oauth2']
  provider :open_id, :store => OpenID::Store::Filesystem.new('/tmp')
  provider :identity, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }
end
