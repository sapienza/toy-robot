# frozen_string_literal: true

require 'toy_robot'
require 'byebug'

ENV['RAILS_ENV'] ||= 'test'

if ENV['COVERAGE']
  require 'simplecov-rcov'
  require 'simplecov'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.start do
    add_filter 'spec/factories' # Don't include vendored stuff
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.order = 'random'
end
