describe EnumIsh::ActiveRecordDefiner do
  let(:user) { User.new }

  context :integer do
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
