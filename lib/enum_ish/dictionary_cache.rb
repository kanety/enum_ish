# frozen_string_literal: true

module EnumIsh
  class DictionaryCache
    def initialize(app)
      @app = app
    end
  
    def call(env)
      EnumIsh::DictionaryCache.enable do
        @app.call(env)
      end
    end

    class << self
      class_attribute :cache_key
      self.cache_key = :_enum_ish_dictionary_cache

      def cache
        Thread.current[cache_key]
      end

      def enable
        Thread.current[cache_key] = {}
        yield
      ensure
        Thread.current[cache_key] = nil
      end
    end
  end
end
