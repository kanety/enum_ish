module EnumIsh
  class Builder
    class << self
      def build(klass, attr, enum, config = {})
        define_text(klass, attr, enum, config)
        define_options(klass, attr, enum, config)

        if config.key?(:default)
          define_default_value(klass, attr, enum, config)
        end

        if config[:predicate]
          define_predicate(klass, attr, enum, config)
        end

        if config[:accessor]
          define_accessor(klass, attr, enum, config)
        end

        if config[:validate]
          define_validate(klass, attr, enum, config)
        end

        if config[:scope]
          define_scope(klass, attr, enum, config)
        end
      end

      def translate(klass, attr, enum, config, options)
        attr_key = [attr, options.delete(:format)].compact.join('/')
        defaults = [:"enum_ish.defaults.#{attr_key}", enum.invert]
        dict = I18n.t("enum_ish.#{klass.name.underscore}.#{attr_key}", options.merge(default: defaults))
        dict = dict.map { |k, v| [k.to_s.to_sym, v.to_s] }.to_h

        translated = enum.map { |k, v| dict[k] ? [k, dict[k]] : [k, v.to_s] }.to_h
        translated = translated.map { |k, v| [enum[k], v] }.to_h unless config[:accessor]
        translated
      end

      private

      def define_text(klass, attr, enum, config)
        method = "#{attr}_text"

        klass.class_eval do
          define_method method do |options = {}|
            value = public_send(attr)
            translated = EnumIsh::Builder.translate(klass, attr, enum, config, options)
            translated[value] || value
          end
        end        
      end

      def define_options(klass, attr, enum, config)
        method = "#{attr}_options"

        klass.class_eval do
          define_singleton_method method do |options = {}|
            translated = EnumIsh::Builder.translate(klass, attr, enum, config, options)
            translated.invert.to_a
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
        if klass.ancestors.include?(ActiveRecord::Base)
          method = "_enum_ish_init_#{attr}".to_sym
          klass.class_eval do
            after_initialize method
            define_method method do
              public_send("#{attr}=", config[:default]) if respond_to?(attr) && public_send(attr).nil?
            end
          end
        else
          mod = Module.new
          mod.module_eval do
            define_method :initialize do |*args|
              public_send("#{attr}=", config[:default]) if respond_to?(attr) && public_send(attr).nil?
              super(*args)
            end
          end
          klass.prepend mod
        end
      end

      def define_accessor(klass, attr, enum, config)
        method = "#{attr}_raw"

        if klass.ancestors.include?(ActiveRecord::Base)
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
        else
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
end
