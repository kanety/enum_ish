describe EnumIsh::ActiveRecordDefiner do
  context :integer do
    let(:model) {
      test_model(User) do
        enum_ish :int, [0, 1, 2]
        enum_ish :aliased_int, { zero: 0, one: 1, two: 2 }, accessor: true
      end
    }
    let(:user) { model.new }

    it 'assigns symbol' do
      user.aliased_int = :one
      expect(user.aliased_int).to eq(:one)
      expect(user.aliased_int_raw).to eq(1)
    end

    it 'assigns string' do
      user.aliased_int = 'one'
      expect(user.aliased_int).to eq(:one)
      expect(user.aliased_int_raw).to eq(1)
    end

    it 'assigns raw value' do
      user.aliased_int = 1
      expect(user.aliased_int).to eq(:one)
      expect(user.aliased_int_raw).to eq(1)
    end

    it 'assigns nil' do
      user.aliased_int = nil
      expect(user.aliased_int).to eq(nil)
      expect(user.aliased_int_raw).to eq(nil)
    end

    it 'assigns unknown value as it is' do
      user.aliased_int = 99
      expect(user.aliased_int).to eq(99)
      expect(user.aliased_int_raw).to eq(99)
    end
  end
end
