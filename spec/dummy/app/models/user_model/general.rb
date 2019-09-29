class UserModel::General < UserModel
  enum_ish :str, ['status2', 'status3'], default: 'status1'
end
