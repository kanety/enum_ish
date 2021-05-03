describe EnumIsh::ActiveRecordDefiner do
  context :float do
    let(:model) {
      test_model(User) do
        enum_ish :flt, [0.5, 1.0, 2.0], validate: true
        enum_ish :aliased_flt, { half: 0.5, one: 1.0, double: 2.0 }, accessor: true, validate: true
      end
    }
    let(:user) { model.new }

    it 'is valid' do
      user.flt = 1.0
      expect(user.valid?).to eq(true)
    end

    it 'is not valid' do
      user.flt = -1.0
      expect(user.valid?).to eq(false)
    end

    it 'is valid' do
      user.aliased_flt = :one
      expect(user.valid?).to eq(true)
    end

    it 'is not valid' do
      user.aliased_flt = -1.0
      expect(user.valid?).to eq(false)
    end
  end
end
