# frozen_string_literal: true

module EnumIsh
  class Dictionary
    CACHE_KEY = :_enum_ish_dictionary_cache

    def initialize(klass, enum, options = {})
      @klass = klass
      @enum = enum
      @options = options
      @dict = cache { Lookup.new(@klass, @enum, @options).call }
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
      if (cache = Thread.current[CACHE_KEY]) != nil
        cache[I18n.locale] ||= {}
        cache[I18n.locale][@klass] ||= {}
        cache[I18n.locale][@klass][@enum] ||= {}
        cache[I18n.locale][@klass][@enum][@optons] ||= yield
      else
        yield
      end
    end

    class << self
      def cache
        Thread.current[CACHE_KEY] = {}
        yield
      ensure
        Thread.current[CACHE_KEY] = nil
      end
    end
  end

  class Lookup
    def initialize(klass, enum, options = {})
      @klass = klass
      @enum = enum
      @options = options
    end

    def call
      i18n = lookup_for(@klass).transform_keys { |k| k.to_s.to_sym }

      dict = {}
      if @enum.setting[:accessor]
        @enum.mapping.each { |k, v| dict[k] = i18n[k].to_s }
      else
        @enum.mapping.each { |k, v| dict[v] = i18n[k].to_s }
      end

      filter(dict)
    end

    private

    def lookup_for(klass)
      key = [@enum.name, @options[:format]].compact.join('/')
      options = (@options[:i18n_options] || {}).merge(default: nil)

      if klass.name.to_s.in?(['ActiveRecord::Base', 'Object'])
        I18n.t(:"enum_ish.defaults.#{key}", **options) || @enum.mapping.invert
      elsif klass.name.blank? || !klass.is_a?(Class)
        resolve(klass.superclass)
      else
        I18n.t(:"enum_ish.#{klass.name.underscore}.#{key}", **options) || lookup_for(klass.superclass)
      end
    end

    def filter(dict)
      if @options[:except]
        except = Array(@options[:except])
        dict.reject! { |k, v| except.include?(k) }
      end
      if @options[:only]
        only = Array(@options[:only])
        dict.select! { |k, v| only.include?(k) }
      end
      dict
    end
  end
end
