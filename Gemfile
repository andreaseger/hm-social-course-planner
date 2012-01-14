source 'http://rubygems.org'

gem 'rails', '3.2.0.rc2'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'therubyracer'
  gem 'compass', ">= 0.12.alpha.1", :require => false
  gem 'compass-susy-plugin', :require => 'susy'

  gem 'sass-rails', ">= 3.1.5"
  gem 'coffee-rails', ">= 3.1.1"
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'modernizr-rails'
gem 'mustache'
gem 'nokogiri', :require => false

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
