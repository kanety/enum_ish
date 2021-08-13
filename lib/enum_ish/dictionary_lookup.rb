module EnumIsh
  class DictionaryLookup
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
      if klass.name.blank? || !klass.is_a?(Class)
        return lookup_for(klass.superclass)
      end

      key = [@enum.name, @options[:format]].compact.join('/')
      options = (@options[:i18n_options] || {}).merge(default: nil)

      if klass.name.to_s.in?(['ActiveRecord::Base', 'Object'])
        I18n.t(:"enum_ish.defaults.#{key}", **options) || @enum.mapping.invert
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
