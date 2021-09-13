source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Flexible authentication solution for Rails with Warden
# https://github.com/heartcombo/devise
gem 'devise', '~> 4.8'

# JWT authentication for devise with configurable token revocation strategies
# https://github.com/waiting-for-dev/devise-jwt
gem 'devise-jwt', '~> 0.8.1'

# Middleware that will make Rack-based apps CORS compatible
# https://github.com/cyu/rack-cors
gem 'rack-cors', '~> 1.1', '>= 1.1.1'

# A Ruby framework for rapid API development with great conventions.
# https://github.com/ruby-grape/grape
gem 'grape', '~> 1.5', '>= 1.5.3'

# Creating entity templates for grape
# https://github.com/ruby-grape/grape-entity
gem 'grape-entity', '~> 0.9.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Fasterer to check various places in your code that could be faster.
  # https://github.com/DamirSvrtan/fasterer
  gem 'fasterer', '~> 0.9.0'

  # Utility to install, configure, and extend Git hooks
  # https://github.com/sds/overcommit
  gem 'overcommit', '~> 0.58.0'

  # Runtime developer console and IRB alternative with powerful introspection capabilities
  # http://pry.github.io/
  gem 'pry', '~> 0.14.1'

  # RSpec results that your continuous integration service can read.
  # https://github.com/sj26/rspec_junit_formatter
  gem 'rspec_junit_formatter', '~> 0.4.1'

  # Testing framework for Rails 5+
  # https://github.com/rspec/rspec-rails
  gem 'rspec-rails', '~> 5.0', '>= 5.0.2'

  # Ruby code style checking and code formatting tool
  # https://rubocop.org/
  gem 'rubocop', '~> 1.19'
  gem 'rubocop-performance', '~> 1.11', '>= 1.11.4'
  gem 'rubocop-rails', '~> 2.11', '>= 2.11.3'
  gem 'rubocop-rspec', '~> 2.4'

  # Autoload dotenv in Rails.
  # https://github.com/bkeepers/dotenv
  gem 'dotenv-rails', '~> 2.7', '>= 2.7.6'

  # Create objects from models
  # https://github.com/thoughtbot/factory_bot_rails
  gem 'factory_bot_rails', '~> 6.2'

  # Generate fake data
  # https://github.com/faker-ruby/faker
  gem 'faker', '~> 2.19'
end

group :development do
  gem 'listen', '~> 3.3'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Annotates Rails/ActiveRecord Models, routes, fixtures, and others based on the database schema.
  # https://github.com/ctran/annotate_models
  gem 'annotate', '~> 3.1', '>= 3.1.1'
end

group :test do
  # Code coverage
  # https://github.com/colszowka/simplecov
  gem 'simplecov', require: false

  # Clear out database between runs
  # https://github.com/DatabaseCleaner/database_cleaner-active_record
  gem 'database_cleaner-active_record', '~> 2.0', '>= 2.0.1'
end
