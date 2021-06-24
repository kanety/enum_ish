class UserModel
  include EnumIsh::Base

  attr_accessor :str
  attr_accessor :aliased_str

  attr_accessor :int
  attr_accessor :aliased_int

  attr_accessor :flt
  attr_accessor :aliased_flt

  attr_accessor :bool
  attr_accessor :aliased_bool

  attr_accessor :array
  attr_accessor :aliased_array

  attr_accessor :status
  enum_ish :status, ['enable', 'disable']
end
