# frozen_string_literal: true

require_relative 'enum'
require_relative 'dictionary'
require_relative 'errors'
require_relative 'definer'
require_relative 'active_record_definer' if defined?(ActiveRecord::Base)

module EnumIsh
  module Base
    extend ActiveSupport::Concern

    included do
      class_attribute :_enum_ish_enums
      self._enum_ish_enums = {}
    end

    class_methods do
      def enum_ish(name, map, setting = {})
        enum = Enum.new(name, map, Config.defaults.merge(setting))
        self._enum_ish_enums = _enum_ish_enums.merge(name.to_sym => enum)

        if defined?(ActiveRecord::Base) && ancestors.include?(ActiveRecord::Base)
          ActiveRecordDefiner.new(self).define(enum)
        else
          Definer.new(self).define(enum)
        end
      end
    end
  end
end
