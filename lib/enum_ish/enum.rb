# frozen_string_literal: true

module EnumIsh
  class Enum
    class_attribute :features
    self.features = [:text, :options, :predicate, :default, :accessor, :validate, :scope]

    attr_accessor :name
    attr_accessor :mapping
    attr_accessor :setting

    def initialize(name, mapping, setting)
      @name = name
      @mapping = init_mapping(mapping)
      @setting = setting
    end

    features.each do |feature|
      define_method feature do
        setting.fetch(feature)
      end
    end

    def use?(feature)
      @setting.key?(feature)
    end

    def features
      self.class.features.select { |feature| use?(feature) }
    end

    def values
      if use?(:accessor)
        @mapping.keys
      else
        @mapping.values
      end
    end

    def value(key)
      if use?(:accessor)
        key
      else
        @mapping[key]
      end
    end

    def to_raw(value)
      if value.is_a?(Array)
        value.map { |v| @mapping.fetch(v, v) }
      else
        @mapping.fetch(value, value)
      end
    end

    def to_sym(value)
      inverted = @mapping.invert
      if value.is_a?(Array)
        value.map { |v| inverted[v] }
      else
        inverted[value]
      end
    end

    def text_method
      "#{Config.text_prefix}#{@name}#{Config.text_suffix}"
    end

    def options_method
      "#{Config.options_prefix}#{@name}#{Config.options_suffix}"
    end

    def predicate_method(key)
      key = key.to_s.tr('.', '_')
      if predicate.is_a?(Hash) && predicate[:prefix] == false
        "#{key}?"
      else
        "#{@name}_#{key}?"
      end
    end

    def raw_method
      "#{Config.raw_prefix}#{@name}#{Config.raw_suffix}"
    end

    def scope_method(type = nil)
      if type == :negative
        "#{Config.scope_prefix}#{@name}_not#{Config.scope_suffix}"
      else
        "#{Config.scope_prefix}#{@name}#{Config.scope_suffix}"
      end
    end

    private

    def init_mapping(mapping)
      if mapping.is_a?(Array)
        mapping.map do |v|
          k = v.to_s.to_sym
          v = v.to_s if v.is_a?(Symbol)
          [k, v]
        end.to_h
      else
        mapping
      end
    end
  end
end
