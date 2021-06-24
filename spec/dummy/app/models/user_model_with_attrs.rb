if Rails.gem_version >= Gem::Version.new("5.2")
  class UserModelWithAttrs
    include ActiveModel::Model
    include ActiveModel::Attributes
    include EnumIsh::Base

    attribute :str, :string
    attribute :aliased_str, :string

    attribute :int, :integer
    attribute :aliased_int, :integer

    attribute :flt, :float
    attribute :aliased_flt, :float

    attribute :bool, :boolean
    attribute :aliased_bool, :boolean

    attribute :status, :string
    enum_ish :status, ['enable', 'disable']
  end
end
