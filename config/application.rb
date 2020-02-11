# frozen_string_literal: true

require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Checkins
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.beginning_of_week = :sunday
    config.time_zone = "Central Time (US & Canada)"
    config.active_record.default_timezone = :utc
    config.action_dispatch.default_headers = { "X-Frame-Options" => "ALLOWALL" }

    # Settings in config/environments/* take precedence over those specified
    # here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil
    config.generators do |g|
      g.system_tests = nil
      g.scaffold_stylesheet false
    end
  end
end
