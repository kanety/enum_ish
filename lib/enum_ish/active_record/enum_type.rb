module EnumIsh
  module ActiveRecord
    class EnumType < ::ActiveRecord::Type::Value
      def initialize(name, mapping, subtype)
        @name = name
        @mapping = mapping
        @subtype = subtype
      end

      def cast(value)
        if @mapping.has_key?(value)
          value
        elsif @mapping.has_value?(value)
          @mapping.key(value)
        else
          value
        end
      end

      def deserialize(value)
        cast(value)
      end

      def serialize(value)
        @mapping.fetch(value, value)
      end
    end
  end
end
