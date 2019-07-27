# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'rails', github: 'rails/rails', branch: '6-0-stable'

gem 'contracts'
gem 'database_validations'
gem 'jbuilder', '~> 2.5'
gem 'puma', '~> 3.11'
gem 'rubocop', require: false
gem 'sqlite3'

group :development, :test do
  # debugging
  gem 'byebug', platforms: [:mri]
  gem 'pry-rails'
end

group :development do
  gem 'spring'
  gem 'web-console', github: 'rails/web-console'
end

group :test do
  gem 'rspec-rails', '~> 3.8'
  gem 'simplecov', require: false
end
