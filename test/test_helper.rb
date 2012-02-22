# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
  
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require "shoulda"
require "factory_girl"
require "sqlite3"

#require "turn"
  
ActionMailer::Base.delivery_method    = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = "example.com"

Rails.backtrace_cleaner.remove_silencers!

# Include devise helpers for controller tests
class ActionController::TestCase
  self.fixture_path = File.expand_path('../fixtures', __FILE__)
end

class ActiveSupport::TestCase
  self.fixture_path = File.expand_path('../fixtures', __FILE__)
  fixtures :all
end

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| load f }
Dir["#{File.expand_path("../../", __FILE__)}/app/**/*.rb"].each { |f| load f }
