# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.3.1'

gem 'thor' # CLI control

group :development, :test do
  gem 'byebug' # Debug
  gem 'rubocop', require: false # Static analysis of the code
  gem 'rubycritic', require: false # Cyclomatic complexity
end

group :test do
  gem 'rspec'
  gem 'simplecov-rcov', require: false
end
