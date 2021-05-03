describe EnumIsh::ActiveRecordDefiner do
  let(:user) { User.new }

  context :float do
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
