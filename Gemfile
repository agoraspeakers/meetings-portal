# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'rails', github: 'rails/rails', branch: '6-0-stable'

gem 'contracts'
gem 'database_validations'
gem 'devise'
gem 'jbuilder', '~> 2.5'
gem 'omniauth-facebook'
gem 'puma', '~> 3.11'
gem 'rubocop', require: false
gem 'sqlite3'
gem 'webpacker', '~> 4.0', '>= 4.0.7'

group :development, :test do
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
  gem 'simplecov', require: false
end
