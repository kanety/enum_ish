class UserModel::Manager < UserModel
  enum_ish :str, ['status1', 'status2'], default: 'status1'
end
