# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '= 6.1.4.1'
gem 'rswag'
gem 'whenever'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '>= 2.15'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec'
  gem 'rspec-rails', '>= 3.9.0'
  gem 'rubocop'
  gem 'rubocop-rspec', require: false
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov'
  gem 'sql_queries_count'
  gem 'webdrivers'
end

group :development do
  gem 'awesome_print'
  gem 'listen', '~> 3.3'
  gem 'seed_dump'
  gem 'spring'
end

gem 'active_model_serializers'
gem 'bcrypt'
gem 'devise_token_auth'
gem 'sidekiq'
