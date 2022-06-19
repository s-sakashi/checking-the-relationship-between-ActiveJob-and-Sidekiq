require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CheckingTheRelationshipBetweenActivejobAndSidekiq
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.time_zone = "Tokyo"
    config.autoload_paths += Dir["#{config.root}/lib/**/", "#{config.root}/app/enums/**/"]

    if Rails.env.development?
      config.active_job.queue_adapter = :sidekiq
      Sidekiq.configure_server do |config|
        config.redis = { url: "redis://localhost:6379" }
      end

      Sidekiq.configure_client do |config|
        config.redis = { url: "redis://localhost:6379" }
      end
    end

  end
end
