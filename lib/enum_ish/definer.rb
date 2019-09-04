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
          value = public_send(enum.name)
          dic = Dictionary.new(self.class).load(enum, options)
          dic[value] || value
        end
      end        
    end

    def define_options(enum)
      @klass.class_eval do
        define_singleton_method "#{Config.options_prefix}#{enum.name}#{Config.options_suffix}" do |options = {}|
          dic = Dictionary.new(self).load(enum, options)
          dic.to_a.map { |value, label| [label, value] }
        end
      end
    end

    def define_predicate(enum)
      enum.mapping.each do |key, value|
        @klass.class_eval do
          define_method "#{enum.name}_#{key}?".tr('.', '_') do
            public_send(enum.name) == value
          end
        end
      end
    end

    def define_default(enum)
      mod = Module.new
      mod.module_eval do
        define_method :initialize do |*args|
          if respond_to?(enum.name) && public_send(enum.name).nil?
            default = enum.setting[:default]
            default = instance_exec(&default) if default.kind_of?(Proc)
            public_send("#{enum.name}=", default)
          end
          super(*args)
        end
      end
      @klass.prepend mod
    end

    def define_accessor(enum)
      @klass.class_eval do
        define_method "#{Config.raw_prefix}#{enum.name}#{Config.raw_suffix}" do
          instance_variable_get("@#{enum.name}")
        end
        define_method "#{enum.name}" do
          enum.mapping.invert[instance_variable_get("@#{enum.name}")]
        end
        define_method "#{enum.name}=" do |value|
          instance_variable_set("@#{enum.name}", enum.mapping.fetch(value, value))
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
