module EnumIsh
  class Builder
    class ActiveRecord < Builder
      private

      def define_default_value(attr, enum, config)
        method = "_enum_ish_init_#{attr}".to_sym

        @klass.class_eval do
          after_initialize method
          define_method method do
            public_send("#{attr}=", config[:default]) if respond_to?(attr) && public_send(attr).nil?
          end
        end
      end

      def define_accessor(attr, enum, config)
        method = "#{attr}_raw"

        @klass.class_eval do
          define_method method do
            read_attribute(attr)
          end
          define_method "#{attr}" do
            enum.invert[read_attribute(attr)]
          end
          define_method "#{attr}=" do |value|
            write_attribute(attr, enum[value])
          end
        end
      end

      def define_scope(attr, enum, config)
        method = "with_#{attr}"

        @klass.class_eval do
          scope method, ->(value) {
            where(attr => value)
          }
        end
      end
    end
  end
end
