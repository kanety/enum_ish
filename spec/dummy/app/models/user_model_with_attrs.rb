if Rails.gem_version >= Gem::Version.new("5.2")
  class UserModelWithAttrs
    include ActiveModel::Model
    include ActiveModel::Attributes
    extend EnumIsh

    attribute :str, :string
    attribute :aliased_str, :string
    enum_ish :str, ['status1', 'status2', 'status3'], default: 'status1', predicate: true
    enum_ish :aliased_str, { status1: 'status1', status2: 'status2', status3: 'status3' }, default: :status1, accessor: true

    attribute :int, :integer
    attribute :aliased_int, :integer
    enum_ish :int, [0, 1, 2], default: 0, predicate: true
    enum_ish :aliased_int, { zero: 0, one: 1, two: 2 }, default: :zero, accessor: true

    attribute :flt, :float
    attribute :aliased_flt, :float
    enum_ish :flt, [0.5, 1.0, 2.0], default: 0.5, predicate: true
    enum_ish :aliased_flt, { half: 0.5, one: 1.0, double: 2.0 }, default: :half, accessor: true

    attribute :bool, :boolean
    attribute :aliased_bool, :boolean
    enum_ish :bool, [true, false], default: -> { true }, predicate: true
    enum_ish :aliased_bool, { true: true, false: false }, default: :true, accessor: true
  end
end
