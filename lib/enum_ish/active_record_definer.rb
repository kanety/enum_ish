# frozen_string_literal: true

require_relative 'active_record_enum_type'

module EnumIsh
  class ActiveRecordDefiner < EnumIsh::Definer
    def define_default(enum)
      method = "_enum_ish_init_#{enum.name}".to_sym

      @klass.class_eval do
        after_initialize method
        define_method method do
          if respond_to?(enum.name) && public_send(enum.name).nil?
            default = enum.default
            default = instance_exec(&default) if default.kind_of?(Proc)
            public_send("#{enum.name}=", default)
          end
        end
      end
    end

    def define_accessor(enum)
      @klass.class_eval do
        define_method enum.raw_method do
          value = read_attribute(enum.name)
          enum.mapping.fetch(value, value)
        end

        if ActiveRecord.version >= Gem::Version.new('7.2.0.a')
          decorate_attributes([enum.name]) do |_, subtype|
            EnumIsh::ActiveRecordEnumType.new(enum.name, enum.mapping, subtype)
          end
        elsif ActiveRecord.version > Gem::Version.new('7.0.0.a')
          attribute(enum.name) do |subtype|
            EnumIsh::ActiveRecordEnumType.new(enum.name, enum.mapping, subtype)
          end
        elsif ActiveRecord.version > Gem::Version.new('6.1.0.a')
          decorate_attribute_type(enum.name) do |subtype|
            EnumIsh::ActiveRecordEnumType.new(enum.name, enum.mapping, subtype)
          end
        else
          decorate_attribute_type(enum.name, :enum) do |subtype|
            EnumIsh::ActiveRecordEnumType.new(enum.name, enum.mapping, subtype)
          end
        end
      end
    end

    def define_scope(enum)
      @klass.class_eval do
        scope enum.scope_method, ->(*value) {
          where(enum.name => enum.mapping.fetch(value, value))
        }
        scope enum.scope_method(:negative), ->(*value) {
          where.not(enum.name => enum.mapping.fetch(value, value))
        }
      end
    end
  end
end
