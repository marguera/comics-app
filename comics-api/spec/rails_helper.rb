# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

def comics_api_response_json
  { 
    data: {
      results: [
        { id: 1, title: "title 1", thumbnail: { path: "p1", extension: "e1" } },
        { id: 2, title: "title 2", thumbnail: { path: "p1", extension: "e1" } },
        { id: 3, title: "title 3", thumbnail: { path: "p1", extension: "e1" } },
        { id: 4, title: "title 4", thumbnail: { path: "p1", extension: "e1" } },
        { id: 5, title: "title 5", thumbnail: { path: "p1", extension: "e1" } }
      ]
    }
  }.to_json
end

def comics_api_wrapper
  MarvelApiAdapter.new(
    public_key: "123",
    private_key: "456",
    timestamp: 1,
  )
end