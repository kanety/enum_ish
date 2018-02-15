module EnumIsh
  class Builder
    class << self
      def build(klass, attr, enum, config = {})
        if config[:text]
          define_text(klass, attr, enum, config)
        end

        if config[:options]
          define_options(klass, attr, enum, config)
        end

        if config.key?(:default)
          if klass.ancestors.include?(ActiveRecord::Base)
            define_default_value_for_ar(klass, attr, enum, config)
          else
            define_default_value(klass, attr, enum, config)
          end
        end

        if config[:predicate]
          define_predicate(klass, attr, enum, config)
        end

        if config[:accessor]
          if klass.ancestors.include?(ActiveRecord::Base)
            define_accessor_for_ar(klass, attr, enum, config)
          else
            define_accessor(klass, attr, enum, config)
          end
        end

        if config[:validate]
          define_validate(klass, attr, enum, config)
        end

        if config[:scope]
          define_scope(klass, attr, enum, config)
        end
      end

      private

      def define_text(klass, attr, enum, config)
        method = "#{attr}_text"

        klass.class_eval do
          define_method method do |options = {}|
            value = public_send(attr)
            dic = EnumIsh::Dictionary.load(klass, attr, enum, config, options)
            dic[value] || value
          end
        end        
      end

      def define_options(klass, attr, enum, config)
        method = "#{attr}_options"

        klass.class_eval do
          define_singleton_method method do |options = {}|
            dic = EnumIsh::Dictionary.load(klass, attr, enum, config, options)
            dic.invert.to_a
          end
        end
      end

      def define_predicate(klass, attr, enum, config)
        enum.each do |key, value|
          method = "#{attr}_#{key}?".tr('.', '_')
          klass.class_eval do
            define_method method do
              public_send(attr) == value
            end
          end
        end
      end

      def define_default_value(klass, attr, enum, config)
        mod = Module.new
        mod.module_eval do
          define_method :initialize do |*args|
            public_send("#{attr}=", config[:default]) if respond_to?(attr) && public_send(attr).nil?
            super(*args)
          end
        end
        klass.prepend mod
      end

      def define_default_value_for_ar(klass, attr, enum, config)
        method = "_enum_ish_init_#{attr}".to_sym

        klass.class_eval do
          after_initialize method
          define_method method do
            public_send("#{attr}=", config[:default]) if respond_to?(attr) && public_send(attr).nil?
          end
        end
      end

      def define_accessor(klass, attr, enum, config)
        method = "#{attr}_raw"

        klass.class_eval do
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

      def define_accessor_for_ar(klass, attr, enum, config)
        method = "#{attr}_raw"

        klass.class_eval do
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

      def define_validate(klass, attr, enum, config)
        klass.class_eval do
          validates attr, inclusion: { in: enum.values }, allow_nil: true
        end
      end

      def define_scope(klass, attr, enum, config)
        method = "with_#{attr}"

        klass.class_eval do
          scope method, ->(value) {
            where(attr => value)
          }
        end
      end
    end
  end

  class Dictionary
    class << self
      def load(klass, attr, enum, config, options)
        dict = load_i18n(klass, attr, enum, options)

        translated = enum.map { |k, v| dict[k] ? [k, dict[k]] : [k, v.to_s] }.to_h
        translated = translated.map { |k, v| [enum[k], v] }.to_h unless config[:accessor]
        translated
      end

      private

      def load_i18n(klass, attr, enum, options)
        attr_key = [attr, options.delete(:format)].compact.join('/')
        i18n_options = options.merge(default: [:"enum_ish.defaults.#{attr_key}", enum.invert])
        dict = I18n.t("enum_ish.#{klass.name.underscore}.#{attr_key}", i18n_options)
        dict.map { |k, v| [k.to_s.to_sym, v.to_s] }.to_h
      end
    end
  end
end
