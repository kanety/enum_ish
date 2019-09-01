module EnumIsh
  class Dictionary
    def initialize(klass)
      @klass = klass
    end

    def load(enum, options = {})
      translated = translate(enum, options)
      filter(translated, options)
    end

    private

    def translate(enum, options)
      dict = load_dict(enum, options)
      translated = enum.mapping.map { |k, v| dict[k] ? [k, dict[k]] : [k, v.to_s] }.to_h
      translated = translated.map { |k, v| [enum.mapping[k], v] }.to_h unless enum.setting[:accessor]
      translated
    end

    def load_dict(enum, options)
      key = i18n_key(enum, options)
      dict = I18n.t("enum_ish.#{@klass.name.underscore}.#{key}", i18n_options(enum, options))
      dict.map { |k, v| [k.to_s.to_sym, v.to_s] }.to_h
    end

    def i18n_key(enum, options)
      [enum.name, options[:format]].compact.join('/')
    end

    def i18n_options(enum, options)
      key = i18n_key(enum, options)
      opts = options[:i18n_options] || {}
      opts.merge(default: [:"enum_ish.defaults.#{key}", enum.mapping.invert])
    end

    def filter(translated, options)
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
  end
end
