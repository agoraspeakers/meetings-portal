source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'rails', github: "rails/rails", branch: "6-0-stable"

gem 'sqlite3'
gem 'puma', '~> 3.11'
gem 'jbuilder', '~> 2.5'
gem 'contracts'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', github: 'rails/web-console'
  gem 'spring'
end
