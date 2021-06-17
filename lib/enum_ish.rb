# frozen_string_literal: true

require 'active_support'
require 'enum_ish/version'
require 'enum_ish/errors'
require 'enum_ish/config'
require 'enum_ish/enum'
require 'enum_ish/dictionary'
require 'enum_ish/definer'
require 'enum_ish/active_record_definer' if defined?(ActiveRecord::Base)

module EnumIsh
  def enum_ish(name, map, config = {})
    enum = Enum.new(name, map, config)

    self._enum_ish_enums ||= {}
    self._enum_ish_enums[name.to_sym] = enum

    if defined?(ActiveRecord::Base) && self.ancestors.include?(ActiveRecord::Base)
      ActiveRecordDefiner.new(self).define(enum)
    else
      Definer.new(self).define(enum)
    end
  end

  def self.extended(klass)
    super
    klass.class_attribute :_enum_ish_enums
    klass.extend ClassMethods
  end

  module ClassMethods
    def inherited(subclass)
      super
      subclass._enum_ish_enums = self._enum_ish_enums.dup
    end
  end
end
