require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  Capybara.register_driver :headless do |app|
    Capybara::Selenium::Driver.new app,
                                   browser: :chrome,
                                   clear_session_storage: true,
                                   clear_local_storage: true,
                                   capabilities: [Selenium::WebDriver::Chrome::Options.new(
                                     args: %w[headless disable-gpu no-sandbox
                                              window-size=1024,768]
                                   )]
  end

  config.before(:each, type: :system) do
    driven_by :headless
  end

  # Ensures that all javascript tests use :headless_chrome
  config.before(:each, type: :system, js: true) do
    # Can be switched to :chrome if you want to see it working
    driven_by :headless
  end
end
