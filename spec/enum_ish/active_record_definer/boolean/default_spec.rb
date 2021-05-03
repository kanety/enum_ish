describe EnumIsh::ActiveRecordDefiner do
  context :boolean do
    let(:model) {
      test_model(User) do
        enum_ish :bool, [true, false], default: -> { true }
        enum_ish :aliased_bool, { true: true, false: false }, accessor: true, default: -> { :true }
      end
    }
    let(:user) { model.new }

    it 'has default value' do
      expect(user.bool).to eq(true)
      expect(user.aliased_bool).to eq(:true)
    end
  end
end
