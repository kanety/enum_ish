require_relative 'boot'

# Pick the frameworks you want:
require "active_record/railtie"

Bundler.require(*Rails.groups)
require "enum_ish"

module Dummy
  class Application < Rails::Application
    config.i18n.default_locale = :ja
  end
end
