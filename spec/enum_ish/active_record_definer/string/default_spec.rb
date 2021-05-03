describe EnumIsh::ActiveRecordDefiner do
  let(:user) { User.new }

  context :string do
    it 'has default value' do
      expect(user.str).to eq('status1')
    end
  end
end
