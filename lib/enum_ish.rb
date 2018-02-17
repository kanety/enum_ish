require 'active_support'
require 'enum_ish/version'
require 'enum_ish/builder'

module EnumIsh
  def enum_ish(attr, enum, config = {})
    [:text, :options].each do |key|
      config[key] = true unless config.key?(key)
    end

    Builder.new(self).build(attr, enum, config)
  end
end
