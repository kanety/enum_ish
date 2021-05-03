describe EnumIsh::ActiveRecordDefiner do
  let(:user) { User.new }

  context :integer do
    it 'has default value' do
      expect(user.int).to eq(0)
    end
  end
end
