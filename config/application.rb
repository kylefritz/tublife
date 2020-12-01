require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tublife
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # OliveBranch converts snake_case to camelCase
    rails_routes = -> (env) { env['PATH_INFO'].match(/^\/rails/) }
    config.middleware.use OliveBranch::Middleware, inflection: "camel", exclude_params: rails_routes, exclude_response: rails_routes

    config.time_zone = 'Eastern Time (US & Canada)'
  end
end
