describe EnumIsh::ActiveRecordDefiner do
  let(:user) { User.new }

  context :boolean do
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
