require 'simplecov'
SimpleCov.start

require 'rails_helper'

def user_models
  models = [UserModel]
  models << UserModelWithAttrs if Rails.gem_version >= Gem::Version.new("5.2")
  models
end
