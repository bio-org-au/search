# frozen_string_literal: true
Rails.application.configure do
  # Settings specified here will take precedence over those in
  # config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static file server for tests with Cache-Control for performance.
  config.serve_static_files   = true
  config.static_cache_control = "public, max-age=3600"

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Randomize the order test cases are executed.
  config.active_support.test_order = :random

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
end

ENV["SHARD"] = "test"

begin
  raise "no_shard_set" if (ENV["SHARD"]).nil?
  puts %(Configuring shard: #{ENV['SHARD']})
rescue
  puts "=" * 100
  puts "Expected the SHARD environmental variable to be set."
  puts "Application start up will now fail."
  puts "ENV['SHARD']: #{ENV['SHARD']}"
  puts "=" * 100
  raise
end

Rails.application.config.database_yml_file_path =
  "#{ENV['HOME']}/.nsl/test/#{ENV['SHARD']}-search-database.yml"
puts "Rails.application.config.database_yml_file_path:
#{Rails.application.config.database_yml_file_path}"

begin
  file_path = "#{ENV['HOME']}/.nsl/test/#{ENV['SHARD']}-search-config.rb"
  puts "Loading config from: #{file_path}"
  load file_path
rescue LoadError
  puts "=" * 100
  puts "Unable to find the config file: #{file_path}"
  puts "Application start up will now fail."
  puts "=" * 100
  raise
end
Rails.configuration.nsl_path = "http://localhost:2016/"
Rails.configuration.flora_path = "http://localhost:2016/flora"
Rails.configuration.fauna_path = "http://localhost:2016/fauna"
