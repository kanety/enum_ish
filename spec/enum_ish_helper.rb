def user_models
  models = [UserModel]
  models << UserModelWithAttrs if Rails.gem_version >= Gem::Version.new("5.2")
  models
end

def test_model(base, &block)
  Class.new(base) do
    def self.name
      "TestModel"
    end

    instance_exec(&block)
  end
end
