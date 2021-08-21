# frozen_string_literal: true

module EnumIsh
  class Config
    class_attribute :data

    self.data = {
      defaults: { text: true, options: true },
      text_prefix: '',
      text_suffix: '_text',
      options_prefix: '',
      options_suffix: '_options',
      raw_prefix: '',
      raw_suffix: '_raw',
      scope_prefix: 'with_',
      scope_suffix: ''
    }

    data.keys.each do |key|
      define_singleton_method "#{key}" do
        data[key]
      end

      define_singleton_method "#{key}=" do |val|
        data[key] = val
      end
    end
  end
end
