require 'active_support'
require 'enum_ish/version'
require 'enum_ish/errors'
require 'enum_ish/config'
require 'enum_ish/enum'
require 'enum_ish/dictionary'
require 'enum_ish/definer/base'
require 'enum_ish/definer/active_record' if defined?(ActiveRecord::Base)

module EnumIsh
  def enum_ish(name, map, config = {})
    enum = Enum.new(name, map, config)

    self.class.class_attribute :_enum_ish_enums unless self.class.respond_to?(:_enum_ish_enums)
    self.class._enum_ish_enums ||= []
    self.class._enum_ish_enums << enum

    if defined?(ActiveRecord::Base) && self.ancestors.include?(ActiveRecord::Base)
      Definer::ActiveRecord.new(self).define(enum)
    else
      Definer::Base.new(self).define(enum)
    end
  end
end
