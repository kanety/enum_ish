class UserModel::Manager < UserModel
  enum_ish :status, ['disable'], default: 'disable'
end
