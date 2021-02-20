# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'mongoid-rspec'
require 'support/factory_bot'

DatabaseCleaner[:mongoid].strategy = :deletion

RSpec.configure do |config|
  config.include Mongoid::Matchers
end