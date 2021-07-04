# frozen_string_literal: true

require 'active_support'
require 'enum_ish/version'
require 'enum_ish/config'
require 'enum_ish/base'
require 'enum_ish/dictionary_cache'

module EnumIsh
  class << self
    def configure
      yield Config
    end

    def config
      Config
    end
  end
end
