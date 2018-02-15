require 'active_support'
require 'enum_ish/version'
require 'enum_ish/builder'

module EnumIsh
  def enum_ish(attr, enum, config = {})
    if enum.is_a?(Array)
      enum = enum.map { |v|
        k = v.to_s.to_sym
        v = v.to_s if v.is_a?(Symbol)
        [k, v]
      }.to_h
    end

    config[:text] = true unless config.key?(:text)
    config[:options] = true unless config.key?(:options)

    Builder.build(self, attr, enum, config)
  end
end
