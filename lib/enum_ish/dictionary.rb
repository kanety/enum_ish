# frozen_string_literal: true

module EnumIsh
  class Dictionary
    def initialize(klass, enum, options = {})
      @klass = klass
      @enum = enum
      @options = options
      @dict = load_dict
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

    def load_dict
      i18n = load_from_i18n.transform_keys { |k| k.to_s.to_sym }

      dict = {}
      if @enum.setting[:accessor]
        @enum.mapping.each { |k, v| dict[k] = i18n[k].to_s }
      else
        @enum.mapping.each { |k, v| dict[v] = i18n[k].to_s }
      end

      filter(dict)
    end

    def load_from_i18n
      key = [@enum.name, @options[:format]].compact.join('/')
      options = (@options[:i18n_options] || {}).merge(default: nil)
      dict = I18n.t(:"enum_ish.#{@klass.name.underscore}.#{key}", **options)
      return dict if dict

      i18n_ancestors.each do |ancestor|
        dict = I18n.t(:"enum_ish.#{ancestor.name.underscore}.#{key}", **options)
        return dict if dict
      end

      dict = I18n.t(:"enum_ish.defaults.#{key}", **options)
      return dict if dict

      @enum.mapping.invert
    end

    def i18n_ancestors
      @klass.ancestors.drop(1)
            .take_while { |a| a.name != 'ActiveRecord::Base' && a.name != 'Object' }
            .select { |a| a.is_a?(Class) && !a.name.empty? }
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
