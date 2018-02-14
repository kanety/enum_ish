class UserModel
  extend EnumIsh

  attr_accessor :str, :int, :flt, :bool
  enum_ish :str, ['status1', 'status2', 'status3'], default: 'status1', predicate: true
  enum_ish :int, [0, 1, 2], default: 0, predicate: true
  enum_ish :flt, [0.5, 1.0, 2.0], default: 0.5, predicate: true
  enum_ish :bool, [true, false], default: true, predicate: true

  attr_accessor :aliased_str, :aliased_int, :aliased_flt, :aliased_bool
  enum_ish :aliased_str, { status1: 'status1', status2: 'status2', status3: 'status3' }, default: :status1, accessor: true
  enum_ish :aliased_int, { zero: 0, one: 1, two: 2 }, default: :zero, accessor: true
  enum_ish :aliased_flt, { half: 0.5, one: 1.0, double: 2.0 }, default: :half, accessor: true
  enum_ish :aliased_bool, { true: true, false: false }, default: :true, accessor: true

  attr_accessor :no_translation
  enum_ish :no_translation, [:val1, :val2, :val3]
end
