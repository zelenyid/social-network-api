source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'

group :development, :test do
  gem 'byebug'
  gem 'fasterer', '~> 0.9.0'
  gem 'rubocop', '~> 1.19'
  gem 'rubocop-performance', '~> 1.11', '>= 1.11.4'
  gem 'rubocop-rails', '~> 2.11', '>= 2.11.3'
  gem 'rubocop-rspec', '~> 2.4'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end
