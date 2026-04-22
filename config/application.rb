  require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Prr2ApiProject
  class Application < Rails::Application
    # Source - https://stackoverflow.com/a/64640285
    # Posted by Aboozar Rajabi
    # Retrieved 2026-04-11, License - CC BY-SA 4.0

    config.active_job.queue_adapter = :delayed_job
    I18n.load_path += Dir[File.expand_path("config/locales") + "/*.yml"]
    I18n.default_locale = :cs # (note that `en` is already the default!)



    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = false

  end
end
