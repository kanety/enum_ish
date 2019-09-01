module EnumIsh
  module Definer
    class ActiveRecord < Base
      private

      def define_default(enum)
        method = "_enum_ish_init_#{enum.name}".to_sym

        @klass.class_eval do
          after_initialize method
          define_method method do
            if respond_to?(enum.name) && public_send(enum.name).nil?
              default = enum.setting[:default]
              default = instance_exec(&default) if default.kind_of?(Proc)
              public_send("#{enum.name}=", default)
            end
          end
        end
      end

      def define_accessor(enum)
        @klass.class_eval do
          define_method "#{enum.name}_raw" do
            read_attribute(enum.name)
          end
          define_method "#{enum.name}" do
            enum.mapping.invert[read_attribute(enum.name)]
          end
          define_method "#{enum.name}=" do |value|
            write_attribute(enum.name, enum.mapping[value])
          end
        end
      end

      def define_scope(enum)
        @klass.class_eval do
          scope "with_#{enum.name}", ->(value) {
            where(enum.name => (enum.mapping[value] || value))
          }
        end
      end
    end
  end
end
