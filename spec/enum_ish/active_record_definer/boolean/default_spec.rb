describe EnumIsh::ActiveRecordDefiner do
  let(:user) { User.new }

  context :boolean do
    it 'has default value' do
      expect(user.bool).to eq(true)
    end
  end
end
