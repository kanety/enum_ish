class OtherModel
  extend EnumIsh

  attr_accessor :no_translation
  enum_ish :no_translation, [:val1, :val2, :val3]

  attr_accessor :same_label
  enum_ish :same_label,  ['value1', 'value2']
end
