describe EnumIsh::ActiveRecordDefiner do
  let(:user) { User.new }

  context :string do
    it 'assigns symbol' do
      user.aliased_str = :status2
      expect(user.aliased_str).to eq(:status2)
      expect(user.aliased_str_raw).to eq('status2')
    end

    it 'assigns string' do
      user.aliased_str = 'status2'
      expect(user.aliased_str).to eq(:status2)
      expect(user.aliased_str_raw).to eq('status2')
    end

    it 'assigns raw value' do
      user.aliased_str = 'status2'
      expect(user.aliased_str).to eq(:status2)
      expect(user.aliased_str_raw).to eq('status2')
    end

    it 'assigns nil' do
      user.aliased_str = nil
      expect(user.aliased_str).to eq(nil)
      expect(user.aliased_str_raw).to eq(nil)
    end

    it 'assigns unknown value as it is' do
      user.aliased_str = 'unknown'
      expect(user.aliased_str).to eq('unknown')
      expect(user.aliased_str_raw).to eq('unknown')
    end
  end
end
