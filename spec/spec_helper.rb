# Configure Rails Envinronment
ENV['RAILS_ENV'] = 'test'

require File.expand_path('../dummy/config/environment.rb',  __FILE__)
require 'rails/test_help'
require 'rspec/rails'
require 'factory_bot_rails'
require 'database_cleaner'
require 'pry'

ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = false
ActionMailer::Base.default_url_options[:host] = 'test.com'

Rails.backtrace_cleaner.remove_silencers!

# Run any available migration
ActiveRecord::Migrator.migrate File.expand_path('../dummy/db/migrate/', __FILE__)

# Load support files
FactoryBot.definition_file_paths << File.join(File.dirname(__FILE__), '/dummy/spec/factories')
FactoryBot.find_definitions

RSpec.configure do |config|
  # Remove this line if you don't want RSpec's should and should_not
  # methods or matchers
  require 'rspec/expectations'
  config.include RSpec::Matchers

  # == Mock Framework
  config.mock_with :rspec
  config.infer_spec_type_from_file_location!

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

OVERLAP_TIME_RANGES = {
  'has same starts_at and ends_at' => ['2011-01-05'.to_date, '2011-01-08'.to_date],
  'starts before starts_at and ends after ends_at' => ['2011-01-04'.to_date, '2011-01-09'.to_date],
  'starts before starts_at and ends inside' => ['2011-01-04'.to_date, '2011-01-06'.to_date],
  'starts inside and ends after ends_at' => ['2011-01-06'.to_date, '2011-01-09'.to_date],
  'starts inside and ends inside' => ['2011-01-06'.to_date, '2011-01-07'.to_date],
  'starts at same time and ends inside' => ['2011-01-05'.to_date, '2011-01-07'.to_date],
  'starts inside and ends at same time' => ['2011-01-06'.to_date, '2011-01-08'.to_date],
  'starts before and ends at time of start' => ['2011-01-03'.to_date, '2011-01-05'.to_date],
  'starts at time of end and ends after' => ['2011-01-08'.to_date, '2011-01-19'.to_date]
}
