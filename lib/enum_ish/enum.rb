# frozen_string_literal: true

module EnumIsh
  class Enum
    attr_accessor :name
    attr_accessor :mapping
    attr_accessor :setting

    def initialize(name, mapping, setting)
      @name = name
      @mapping = init_mapping(mapping)
      @setting = init_setting(setting)
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

    def init_setting(setting)
      [:text, :options].each do |key|
        setting[key] = true unless setting.key?(key)
      end
      setting
    end
  end
end
