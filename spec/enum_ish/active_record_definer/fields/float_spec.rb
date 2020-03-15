describe EnumIsh::ActiveRecordDefiner do
  let(:user) { User.new }

  context 'float field' do
    it 'has default value' do
      expect(user.flt).to eq(0.5)
    end

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

    it 'has validation' do
      user.flt= -1.0
      user.valid?
      expect(user.errors.keys).to include(:flt)
    end

    it 'has scope' do
      expect(user.class.with_flt(0.5).count).to be(1)
      expect(user.class.with_aliased_flt(:half).count).to be(1)
    end

    it 'handles aliased value in where clause' do
      expect(user.class.where(aliased_flt: :half).count).to be(1)
    end

    it 'handles raw value in where clause' do
      expect(user.class.where(aliased_flt: 0.5).count).to be(1)
    end

    it 'casts from db value' do
      dbuser = user.class.find_by(aliased_str: :status1)
      expect(dbuser.aliased_flt).to be(:half)
    end
  end
end
