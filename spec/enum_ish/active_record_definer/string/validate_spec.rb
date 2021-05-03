describe EnumIsh::ActiveRecordDefiner do
  context :string do
    let(:model) {
      test_model(User) do
        enum_ish :str, ['status1', 'status2', 'status3'], validate: true
        enum_ish :aliased_str, { status1: 'status1', status2: 'status2', status3: 'status3' }, accessor: true, validate: true
      end
    }
    let(:user) { model.new }

    it 'is valid' do
      user.str = 'status1'
      expect(user.valid?).to eq(true)
    end

    it 'is not valid' do
      user.str = 'invalid'
      expect(user.valid?).to eq(false)
    end

    it 'is valid' do
      user.aliased_str = :status1
      expect(user.valid?).to eq(true)
    end

    it 'is not valid' do
      user.aliased_str = 'invalid'
      expect(user.valid?).to eq(false)
    end
  end
end
