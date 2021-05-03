describe EnumIsh::ActiveRecordDefiner do
  context :boolean do
    let(:model) {
      test_model(User) do
        enum_ish :bool, [true, false]
        enum_ish :aliased_bool, { true: true, false: false }, accessor: true
      end
    }
    let(:user) { model.new }

    it 'assigns symbol' do
      user.aliased_bool = :false
      expect(user.aliased_bool).to eq(:false)
      expect(user.aliased_bool_raw).to eq(false)
    end

    it 'assigns string' do
      user.aliased_bool = 'false'
      expect(user.aliased_bool).to eq(:false)
      expect(user.aliased_bool_raw).to eq(false)
    end

    it 'assigns raw value' do
      user.aliased_bool = false
      expect(user.aliased_bool).to eq(:false)
      expect(user.aliased_bool_raw).to eq(false)
    end

    it 'assigns nil' do
      user.aliased_bool = nil
      expect(user.aliased_bool).to eq(nil)
      expect(user.aliased_bool_raw).to eq(nil)
    end
  end
end
