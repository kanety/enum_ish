# frozen_string_literal: true

module EnumIsh
  class Config
    @@options = {
      text_prefix: '',
      text_suffix: '_text',
      options_prefix: '',
      options_suffix: '_options',
      raw_prefix: '',
      raw_suffix: '_raw',
      scope_prefix: 'with_',
      scope_suffix: ''
    }

    @@options.keys.each do |key|
      define_singleton_method "#{key}" do
        @@options[key]
      end

      define_singleton_method "#{key}=" do |val|
        @@options[key] = val
      end
    end

    class << self
      def configure
        yield self
      end
    end
  end
end
