module EnumIsh
  class Builder
    def initialize(klass)
      @klass = klass
    end

    def build(attr, enum, config = {})
      if enum.is_a?(Array)
        enum = enum.map { |v|
          k = v.to_s.to_sym
          v = v.to_s if v.is_a?(Symbol)
          [k, v]
        }.to_h
      end

      [:text, :options, :predicate, :accessor, :validate, :scope].each do |key|
        if config[key]
          send("define_#{key}", attr, enum, config)
        end
      end

      if config.key?(:default)
        define_default_value(attr, enum, config)
      end
    end

    private

    def define_text(attr, enum, config)
      method = "#{attr}_text"

      @klass.class_eval do
        define_method method do |options = {}|
          value = public_send(attr)
          dic = EnumIsh::Dictionary.new(self.class).load(attr, enum, config, options)
          dic[value] || value
        end
      end        
    end

    def define_options(attr, enum, config)
      method = "#{attr}_options"

      @klass.class_eval do
        define_singleton_method method do |options = {}|
          dic = EnumIsh::Dictionary.new(self).load(attr, enum, config, options)
          dic.invert.to_a
        end
      end
    end

    def define_predicate(attr, enum, config)
      enum.each do |key, value|
        method = "#{attr}_#{key}?".tr('.', '_')
        @klass.class_eval do
          define_method method do
            public_send(attr) == value
          end
        end
      end
    end

    def define_default_value(attr, enum, config)
      mod = Module.new
      mod.module_eval do
        define_method :initialize do |*args|
          if respond_to?(attr) && public_send(attr).nil?
            default = if config[:default].kind_of?(Proc)
                        instance_exec(&config[:default])
                      else
                        config[:default]
                      end
            public_send("#{attr}=", default)
          end
          super(*args)
        end
      end
      @klass.prepend mod
    end

    def define_accessor(attr, enum, config)
      method = "#{attr}_raw"

      @klass.class_eval do
        define_method method do
          instance_variable_get("@#{attr}")
        end
        define_method "#{attr}" do
          enum.invert[instance_variable_get("@#{attr}")]
        end
        define_method "#{attr}=" do |value|
          instance_variable_set("@#{attr}", enum[value])
        end
      end
    end

    def define_validate(attr, enum, config)
      @klass.class_eval do
        validates attr, inclusion: { in: enum.values }, allow_nil: true
      end
    end
  end

  class Dictionary
    def initialize(klass)
      @klass = klass
    end

    def load(attr, enum, config, options)
      dict = load_i18n(attr, enum, options)

      translated = enum.map { |k, v| dict[k] ? [k, dict[k]] : [k, v.to_s] }.to_h
      translated = translated.map { |k, v| [enum[k], v] }.to_h unless config[:accessor]

      if options[:except]
        except = Array(options[:except])
        translated.reject! { |k, v| except.include?(k) }
      end
      if options[:only]
        only = Array(options[:only])
        translated.select! { |k, v| only.include?(k) }
      end

      translated
    end

    private

    def load_i18n(attr, enum, options)
      attr_key = [attr, options[:format]].compact.join('/')
      i18n_options = (options[:i18n_options] || {}).merge(default: [:"enum_ish.defaults.#{attr_key}", enum.invert])

      dict = I18n.t("enum_ish.#{@klass.name.underscore}.#{attr_key}", i18n_options)
      dict.map { |k, v| [k.to_s.to_sym, v.to_s] }.to_h
    end
  end
end
