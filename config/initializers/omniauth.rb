require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :identity, :fields => [:name, :email]
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  provider :open_id, :store => OpenID::Store::Filesystem.new('/tmp')
end
