require 'active_support'
require 'enum_ish/version'
require 'enum_ish/config'
require 'enum_ish/enum'
require 'enum_ish/dictionary'
require 'enum_ish/definer/base'
require 'enum_ish/definer/active_record' if defined?(ActiveRecord::Base)

module EnumIsh
  def enum_ish(name, map, config = {})
    enum = Enum.new(name, map, config)

    if defined?(ActiveRecord::Base) && self.ancestors.include?(ActiveRecord::Base)
      Definer::ActiveRecord.new(self).build(enum)
    else
      Definer::Base.new(self).build(enum)
    end
  end
end
