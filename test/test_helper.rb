# frozen_string_literal: true
require 'coveralls'
Coveralls.wear!

require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'coveralls'
require 'simplecov' 
# SimpleCov.start
# Coveralls.wear!
Coveralls.wear!('rails')
# SimpleCov.formatter = Coveralls::SimpleCov::Formatter
# SimpleCov.start do
#   add_filter 'app/secrets'
# end

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryBot::Syntax::Methods
  include AuthHelper
  include ActionMailer::TestHelper
end
