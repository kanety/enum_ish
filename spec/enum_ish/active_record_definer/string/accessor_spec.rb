describe EnumIsh::ActiveRecordDefiner do
  context :string do
    let(:model) {
      test_model(User) do
        enum_ish :str, ['status1', 'status2', 'status3']
        enum_ish :aliased_str, { status1: 'status1', status2: 'status2', status3: 'status3' }, accessor: true
      end
    }
    let(:user) { model.new }

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
