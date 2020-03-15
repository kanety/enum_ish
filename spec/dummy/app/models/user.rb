class User < ActiveRecord::Base
  extend EnumIsh

  enum_ish :str, ['status1', 'status2', 'status3'], default: 'status1', scope: true, validate: true
  enum_ish :aliased_str, { status1: 'status1', status2: 'status2', status3: 'status3' }, scope: true, accessor: true

  enum_ish :int, [0, 1, 2], default: 0, scope: true, validate: true
  enum_ish :aliased_int, { zero: 0, one: 1, two: 2 }, scope: true, accessor: true

  enum_ish :flt, [0.5, 1.0, 2.0], default: 0.5, scope: true, validate: true
  enum_ish :aliased_flt, { half: 0.5, one: 1.0, double: 2.0 }, scope: true, accessor: true

  enum_ish :bool, [true, false], default: -> { true }, scope: true, validate: true
  enum_ish :aliased_bool, { true: true, false: false }, scope: true, accessor: true
end
