require_relative 'active_record_enum_type'

module EnumIsh
  class ActiveRecordDefiner < EnumIsh::Definer
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
        define_method "#{Config.raw_prefix}#{enum.name}#{Config.raw_suffix}" do
          value = read_attribute(enum.name)
          enum.mapping.fetch(value, value)
        end

        args =
          if ActiveRecord.version > Gem::Version.new('6.1.0.a')
            [enum.name]
          else
            [enum.name, :enum]
          end
        decorate_attribute_type(*args) do |subtype|
          EnumIsh::ActiveRecordEnumType.new(enum.name, enum.mapping, subtype)
        end
      end
    end

    def define_scope(enum)
      @klass.class_eval do
        scope "#{Config.scope_prefix}#{enum.name}#{Config.scope_suffix}", ->(value) {
          where(enum.name => enum.mapping.fetch(value, value))
        }
        scope "#{Config.scope_prefix}#{enum.name}_not#{Config.scope_suffix}", ->(value) {
          where.not(enum.name => enum.mapping.fetch(value, value))
        }
      end
    end
  end
end
