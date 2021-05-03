describe EnumIsh::ActiveRecordDefiner do
  let(:user) { User.new }

  context :float do
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
