require 'spec_helper'
require 'shoulda/matchers'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/webkit/matchers'
require 'transactional_capybara/rspec'
require_relative 'support/wait_for_ajax'

ActiveRecord::Migration.maintain_test_schema!

Capybara.javascript_driver = :webkit

Capybara::Webkit.configure do |config|
  config.allow_unknown_urls
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

ActiveJob::Base.queue_adapter = :test

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.include Devise::Test::ControllerHelpers, type: :controller

  config.include Capybara::Webkit::RspecMatchers, type: :feature

  config.include FactoryBot::Syntax::Methods

  config.include Warden::Test::Helpers

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include WaitForAjax, type: :feature
end
