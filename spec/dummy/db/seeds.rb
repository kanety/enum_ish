User.delete_all

User.create(
  str: "status1",
  int: 0,
  flt: 0.5,
  bool: true,
  aliased_str: "status1",
  aliased_int: 0,
  aliased_flt: 0.5,
  aliased_bool: true
)
User.create(
  str: "status2",
  int: 1,
  flt: 1.0,
  bool: false,
  aliased_str: "status2",
  aliased_int: 1,
  aliased_flt: 1.0,
  aliased_bool: false
)
User.create(
  str: "status3",
  int: 2,
  flt: 2.0,
  bool: false,
  aliased_str: "status3",
  aliased_int: 2,
  aliased_flt: 2.0,
  aliased_bool: false
)
