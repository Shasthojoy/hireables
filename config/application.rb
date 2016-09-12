require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hireables
  class Application < Rails::Application

    # Configure react rendering
    config.react.addons = true
    config.react.server_renderer_pool_size  ||= 5
    config.react.server_renderer_timeout    ||= 20
    config.react.server_renderer = React::ServerRendering::SprocketsRenderer
    config.react.server_renderer_options = {
      files: ["react.js", "components.js"],
      replay_console: true,
    }

    # Autoload lib
    config.autoload_paths += Dir["#{config.root}/app/lib/*"]

    # Configure rails g to skip helper/assets files
    config.generators do |g|
      g.assets = false
      g.helper = false
      g.view_specs      false
      g.helper_specs    false
    end

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'fonts.gstatic.com'
        resource '*', headers: :any, methods: [:get, :options]
      end
    end

    # Setup sidekiq
    config.active_job.queue_adapter = :sidekiq

    # Setup browserify with Babel
    config.browserify_rails.commandline_options = "-t babelify --extension=\"es6.js\""
    config.browserify_rails.source_map_environments << "development"
    config.browserify_rails.evaluate_node_modules = true

  end
end
