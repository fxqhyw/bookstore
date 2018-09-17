source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.0'
gem 'pg'
gem 'puma'
gem 'haml-rails'
gem 'sass-rails'
gem 'devise'
gem 'omniauth-facebook'
gem 'activeadmin'
gem 'cancancan'
gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem 'kaminari'
gem 'aasm'
gem 'country_select'
gem 'wicked'
gem 'draper'
gem 'aws-sdk-s3', require: false
gem 'mini_magick'
gem 'figaro'
gem "rectify"
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'turbolinks', '~> 5'
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'rspec-rails'
  gem 'ffaker'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  gem 'rubocop'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'rails_refactor'
end

group :test do
  gem 'capybara'
  gem 'transactional_capybara'
  gem 'capybara-webkit', github: 'thoughtbot/capybara-webkit', branch: 'master'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
