require 'active_support'
require 'enum_ish/version'
require 'enum_ish/errors'
require 'enum_ish/config'
require 'enum_ish/enum'
require 'enum_ish/dictionary'
require 'enum_ish/definer'
require 'enum_ish/active_record/definer' if defined?(::ActiveRecord::Base)

module EnumIsh
  def enum_ish(name, map, config = {})
    enum = Enum.new(name, map, config)

    self.class_attribute :_enum_ish_enums unless self.respond_to?(:_enum_ish_enums)
    self._enum_ish_enums ||= []
    self._enum_ish_enums << enum

    if defined?(::ActiveRecord::Base) && self.ancestors.include?(::ActiveRecord::Base)
      ActiveRecord::Definer.new(self).define(enum)
    else
      Definer.new(self).define(enum)
    end
  end
end
