class User < ActiveRecord::Base
  include EnumIsh::Base

  enum_ish :status, ['enable', 'disable'], default: 'enable', predicate: true, scope: true
end
