class UserModel
  extend EnumIsh

  attr_accessor :str, :aliased_str
  enum_ish :str, ['status1', 'status2', 'status3'], default: 'status1', predicate: true
  enum_ish :aliased_str, { status1: 'status1', status2: 'status2', status3: 'status3' }, default: :status1, accessor: true

  attr_accessor :int, :aliased_int
  enum_ish :int, [0, 1, 2], default: 0, predicate: true
  enum_ish :aliased_int, { zero: 0, one: 1, two: 2 }, default: :zero, accessor: true

  attr_accessor :flt, :aliased_flt
  enum_ish :flt, [0.5, 1.0, 2.0], default: 0.5, predicate: true
  enum_ish :aliased_flt, { half: 0.5, one: 1.0, double: 2.0 }, default: :half, accessor: true

  attr_accessor :bool, :aliased_bool
  enum_ish :bool, [true, false], default: -> { true }, predicate: true
  enum_ish :aliased_bool, { true: true, false: false }, default: :true, accessor: true

  attr_accessor :array, :aliased_array
  enum_ish :array, ['flag1', 'flag2'], default: ['flag1'], predicate: true
  enum_ish :aliased_array, { flag1: 'flag1', flag2: 'flag2' }, default: [:flag1], accessor: true
end
