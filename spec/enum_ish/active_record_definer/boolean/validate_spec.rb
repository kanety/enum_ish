describe EnumIsh::ActiveRecordDefiner do
  context :boolean do
    let(:model) {
      test_model(User) do
        enum_ish :bool, [true, false], validate: true
        enum_ish :aliased_bool, { true: true, false: false }, accessor: true, validate: true
      end
    }
    let(:user) { model.new }

    it 'is valid' do
      user.bool = false
      expect(user.valid?).to eq(true)
    end

    it 'is valid' do
      user.aliased_bool = :false
      expect(user.valid?).to eq(true)
    end
  end
end
