module EnumIsh
  class ActiveRecordEnumType < ActiveRecord::Type::Value
    def initialize(name, mapping, subtype)
      @name = name
      @mapping = mapping
      @subtype = subtype
    end

    def cast(value)
      return if value.nil?
      if @mapping.has_key?(value.to_s.to_sym)
        value.to_s.to_sym
      elsif @mapping.has_value?(value)
        @mapping.key(value)
      else
        value
      end
    end

    def deserialize(value)
      @mapping.key(@subtype.deserialize(value))
    end

    def serialize(value)
      @mapping.fetch(value, value)
    end
  end
end
