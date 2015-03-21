ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require 'minitest/reporters'
require 'webmock/minitest'

Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  ActiveRecord::Migration.check_pending!

  # fixtures :all

  # Add more helper methods to be used by all tests here...
end

# class MiniTest::Spec
#   include FactoryGirl::Syntax::Methods
# end

# class MiniTest::Rails::ActiveSupport::TestCase
#   include FactoryGirl::Syntax::Methods
# end
