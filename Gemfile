source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'nokogiri', :require => false
# Gems used only for assets and not required
# in production environments by default.
group :assets do    gem 'therubyracer'
  gem 'compass', ">= 0.12.alpha.1", :require => false
  gem 'compass-susy-plugin', :require => 'susy'

  gem 'sass-rails', ">= 3.1.5"
  gem 'coffee-rails', ">= 3.1.1"
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'haml-rails'
gem 'modernizr-rails'

#Authentication
gem 'omniauth-identity'#, :git => 'git://github.com/intridea/omniauth-identity.git'
gem "bcrypt-ruby", :require => "bcrypt"
gem 'omniauth-github'#, :git => 'git://github.com/intridea/omniauth-github.git'
gem 'omniauth-openid'#, :git => 'git://github.com/intridea/omniauth-openid.git'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'

#Authorization
gem 'cancan'

group :production, :test do
  gem 'pg'
  gem 'unicorn'
end
group :development do
  gem "capistrano"
  gem 'thin'
end

group :development, :test do
  gem 'sqlite3'
  gem 'pry'
  gem 'rspec-rails'
  gem 'guard-livereload'
  gem 'guard-spork'
end

group :test do
  gem 'simplecov'
  gem 'mocha'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'spork', '>= 0.9.0.rc'
  gem 'guard-rspec'
  gem 'timecop'
end
