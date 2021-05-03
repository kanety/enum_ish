class UserModel::General < UserModel
  enum_ish :status, ['enable'], default: 'enable'
end
