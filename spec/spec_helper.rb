# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

def shoulda_has_many(item)
  related_item = item[:name]
  context "valid object #{related_item}" do
    it do
      valid_item = have_many(related_item)

      [:class_name, :foreign_key].each do |key_name|
        if item.has_key?(key_name)
          val = item[val]
          next if val.blank?
          valid_item = valid_item.send(key_name, val)
        end
      end

      should valid_item
    end
  end
end

def shoulda_has_one(item)
  related_item = item[:name]
  context "valid object #{related_item}" do
    it do
      valid_item = have_one(related_item)

      [:class_name, :foreign_key].each do |key_name|
        if item.has_key?(key_name)
          val = item[val]
          next if val.blank?
          valid_item = valid_item.send(key_name, val)
        end
      end

      should valid_item
    end
  end
end

def shoulda_belongs_to(item)
  related_item = item[:name]
  context "valid object #{related_item}" do
    it do
      valid_item = belong_to(related_item)

      [:class_name, :foreign_key].each do |key_name|
        if item.has_key?(key_name)
          val = item[val]
          next if val.blank?
          valid_item = valid_item.send(key_name, val)
        end
      end

      should valid_item
    end
  end
end