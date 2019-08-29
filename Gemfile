# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 6.0'

gem 'contracts'
gem 'database_validations'
gem 'devise'
gem 'jbuilder', '~> 2.5'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-rails_csrf_protection'
gem 'puma', '~> 3.11'
gem 'rubocop', require: false
gem 'sqlite3'
gem 'webpacker', '~> 4.0', '>= 4.0.7'
gem 'geocoder'

gem 'bundled-without'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker', '~> 2.1'

  # debugging
  gem 'byebug', platforms: [:mri]
  gem 'pry-rails'
  # documentation
  gem 'yard'
end

group :development do
  gem 'spring'
  gem 'web-console', github: 'rails/web-console'
end

group :test do
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 4.0.0.beta2'
  gem 'rspec_junit_formatter'
  gem 'simplecov', require: false
end
