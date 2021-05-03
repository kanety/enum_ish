describe EnumIsh::ActiveRecordDefiner do
  let(:user) { User.new }

  context :string do
    it 'is valid' do
      user.str = 'status1'
      expect(user.valid?).to eq(true)
    end

    it 'is not valid' do
      user.str = 'invalid'
      expect(user.valid?).to eq(false)
    end

    it 'is valid' do
      user.str = :status1
      expect(user.valid?).to eq(true)
    end

    it 'is not valid' do
      user.aliased_str = 'invalid'
      expect(user.valid?).to eq(false)
    end
  end
end
