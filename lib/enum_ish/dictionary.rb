# frozen_string_literal: true

require_relative 'dictionary_lookup'

module EnumIsh
  class Dictionary
    def initialize(klass, enum, options = {})
      @klass = klass
      @enum = enum
      @options = options
      @dict = cache { DictionaryLookup.new(@klass, @enum, @options).call }
    end

    def translate_value(value)
      if value.is_a?(Array)
        value.map { |v| @dict[v] || v }
      else
        @dict[value] || value
      end
    end

    def translate_options
      @dict.to_a.map { |value, label| [label, value] }
    end

    private

    def cache
      if (cache = self.class.cache) != nil
        cache[I18n.locale] ||= {}
        cache[I18n.locale][@klass] ||= {}
        cache[I18n.locale][@klass][@enum] ||= {}
        cache[I18n.locale][@klass][@enum][@options] ||= yield
      else
        yield
      end
    end

    class << self
      class_attribute :cache_key
      self.cache_key = :_enum_ish_dictionary_cache

      def cache
        Thread.current[cache_key]
      end

      def with_cache
        Thread.current[cache_key] = {}
        yield
      ensure
        Thread.current[cache_key] = nil
      end
    end
  end
end
