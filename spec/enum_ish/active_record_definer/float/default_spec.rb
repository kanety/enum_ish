describe EnumIsh::ActiveRecordDefiner do
  let(:user) { User.new }

  context :float do
    it 'has default value' do
      expect(user.flt).to eq(0.5)
    end
  end
end
