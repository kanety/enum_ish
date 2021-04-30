class ShortPredicate
  extend EnumIsh

  attr_accessor :status
  enum_ish :status,  [:status1, :status2], predicate: { prefix: false }
end
