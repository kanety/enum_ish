describe EnumIsh::ActiveRecordDefiner do
  context :float do
    let(:model) {
      test_model(User) do
        enum_ish :flt, [0.5, 1.0, 2.0]
        enum_ish :aliased_flt, { half: 0.5, one: 1.0, double: 2.0 }, accessor: true
      end
    }
    let(:user) { model.new }

    it 'assigns symbol' do
      user.aliased_flt = :double
      expect(user.aliased_flt).to eq(:double)
      expect(user.aliased_flt_raw).to eq(2.0)
    end

    it 'assigns string' do
      user.aliased_flt = 'double'
      expect(user.aliased_flt).to eq(:double)
      expect(user.aliased_flt_raw).to eq(2.0)
    end

    it 'assigns raw value' do
      user.aliased_flt = 2.0
      expect(user.aliased_flt).to eq(:double)
      expect(user.aliased_flt_raw).to eq(2.0)
    end

    it 'assigns nil' do
      user.aliased_flt = nil
      expect(user.aliased_flt).to eq(nil)
      expect(user.aliased_flt_raw).to eq(nil)
    end

    it 'assigns unknown value as it is' do
      user.aliased_flt = 99.0
      expect(user.aliased_flt).to eq(99.0)
      expect(user.aliased_flt_raw).to eq(99.0)
    end
  end
end
