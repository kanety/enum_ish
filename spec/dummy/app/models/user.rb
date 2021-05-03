class User < ActiveRecord::Base
  extend EnumIsh

  enum_ish :status, ['enable', 'disable'], default: 'enable', predicate: true, scope: true
end
