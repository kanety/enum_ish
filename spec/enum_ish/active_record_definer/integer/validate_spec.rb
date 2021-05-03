describe EnumIsh::ActiveRecordDefiner do
  context :integer do
    let(:model) {
      test_model(User) do
        enum_ish :int, [0, 1, 2], validate: true
        enum_ish :aliased_int, { zero: 0, one: 1, two: 2 }, accessor: true, validate: true
      end
    }
    let(:user) { model.new }

    it 'is valid' do
      user.int = 'one'
      expect(user.valid?).to eq(true)
    end

    it 'is not valid' do
      user.int = -1
      expect(user.valid?).to eq(false)
    end

    it 'is valid' do
      user.aliased_int = :one
      expect(user.valid?).to eq(true)
    end

    it 'is not valid' do
      user.aliased_int = -1
      expect(user.valid?).to eq(false)
    end
  end
end
