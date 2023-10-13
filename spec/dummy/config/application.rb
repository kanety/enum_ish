require_relative 'boot'

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "active_job/railtie"

Bundler.require(*Rails.groups)
require "enum_ish"

module Dummy
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f if config.respond_to?(:load_defaults)

    config.i18n.default_locale = :ja
  end
end
