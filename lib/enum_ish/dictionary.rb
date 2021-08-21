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
      @dict.to_a.map { |value, text| [text, value] }
    end

    private

    def cache
      if (cache = EnumIsh::DictionaryCache.cache) != nil
        cache[I18n.locale] ||= {}
        cache[I18n.locale][@klass] ||= {}
        cache[I18n.locale][@klass][@enum] ||= {}
        cache[I18n.locale][@klass][@enum][@options] ||= yield
      else
        yield
      end
    end
  end
end
