source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'


# Gems used only for assets and not required
# in production environments by default.
group :assets do    gem 'therubyracer'
    gem 'compass', "~> 0.12.alpha", :require => false
    gem 'compass-susy-plugin', :require => 'susy'

  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

  gem 'haml-rails'
  gem 'modernizr-rails'

  group :development do
    gem "capistrano"
  end

  group :development, :test do
    gem 'sqlite3'
    gem 'pry'
    gem 'rspec-rails'
  end

  group :test do
    gem 'mocha'
    gem 'capybara'
    gem 'factory_girl_rails'
    gem 'spork', '> 0.9.0.rc'
    gem 'guard-livereload'
    gem 'guard-rspec'
    gem 'guard-spork'
  end
