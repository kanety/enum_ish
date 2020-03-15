module EnumIsh
  class Definer
    def initialize(klass)
      @klass = klass
    end

    def define(enum)
      [:text, :options, :predicate, :default, :accessor, :validate, :scope].each do |type|
        send("define_#{type}", enum) if enum.setting[type]
      end
    end

    private

    def define_text(enum)
      @klass.class_eval do
        define_method "#{Config.text_prefix}#{enum.name}#{Config.text_suffix}" do |options = {}|
          dict = Dictionary.new(self.class, enum, options)
          dict.translate_value(public_send(enum.name))
        end
      end
    end

    def define_options(enum)
      @klass.class_eval do
        define_singleton_method "#{Config.options_prefix}#{enum.name}#{Config.options_suffix}" do |options = {}|
          dict = Dictionary.new(self, enum, options)
          dict.translate_options
        end
      end
    end

    def define_predicate(enum)
      enum.mapping.each do |enum_key, enum_value|
        @klass.class_eval do
          define_method "#{enum.name}_#{enum_key}?".tr('.', '_') do
            value = public_send(enum.name)
            if value.is_a?(Array)
              value == [enum_value]
            else
              value == enum_value
            end
          end
        end
      end
    end

    def define_default(enum)
      mod = Module.new
      mod.module_eval do
        define_method :initialize do |*args|
          super(*args)
          if respond_to?(enum.name) && public_send(enum.name).nil?
            default = enum.setting[:default]
            default = instance_exec(&default) if default.kind_of?(Proc)
            public_send("#{enum.name}=", default)
          end
        end
      end
      @klass.send(:include, mod)
    end

    def define_accessor(enum)
      @klass.class_eval do
        define_method "#{Config.raw_prefix}#{enum.name}#{Config.raw_suffix}" do
          instance_variable_get("@#{enum.name}")
        end
        define_method "#{enum.name}" do
          enum.to_sym(instance_variable_get("@#{enum.name}"))
        end
        define_method "#{enum.name}=" do |value|
          instance_variable_set("@#{enum.name}", enum.to_raw(value))
        end
      end
    end

    def define_validate(enum)
      @klass.class_eval do
        validates enum.name, inclusion: { in: enum.mapping.values }, allow_nil: true
      end
    end

    def define_scope(enum)
      raise EnumIsh::Error.new(':scope option can be used for ActiveRecord only.')
    end
  end
end
