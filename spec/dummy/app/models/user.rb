class User < ActiveRecord::Base
  extend EnumIsh

  enum_ish :status, ['enable', 'disable']
end
