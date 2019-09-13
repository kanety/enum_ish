describe EnumIsh::ActiveRecordDefiner do
  context 'ActiveRecord' do
    let(:user) { User.new }

    it 'has default value' do
      expect(user.str).to eq('status1')
      expect(user.int).to eq(0)
      expect(user.flt).to eq(0.5)
      expect(user.bool).to eq(true)
    end

    it 'assigns symbol' do
      user.aliased_str = :status2
      expect(user.aliased_str).to eq(:status2)
      expect(user.aliased_str_raw).to eq('status2')

      user.aliased_int = :one
      expect(user.aliased_int).to eq(:one)
      expect(user.aliased_int_raw).to eq(1)

      user.aliased_flt = :double
      expect(user.aliased_flt).to eq(:double)
      expect(user.aliased_flt_raw).to eq(2.0)

      user.aliased_bool = :false
      expect(user.aliased_bool).to eq(:false)
      expect(user.aliased_bool_raw).to eq(false)
    end

    it 'assigns string' do
      user.aliased_str = 'status2'
      expect(user.aliased_str).to eq(:status2)
      expect(user.aliased_str_raw).to eq('status2')

      user.aliased_int = 'one'
      expect(user.aliased_int).to eq(:one)
      expect(user.aliased_int_raw).to eq(1)

      user.aliased_flt = 'double'
      expect(user.aliased_flt).to eq(:double)
      expect(user.aliased_flt_raw).to eq(2.0)

      user.aliased_bool = 'false'
      expect(user.aliased_bool).to eq(:false)
      expect(user.aliased_bool_raw).to eq(false)
    end

    it 'assigns raw value' do
      user.aliased_str = 'status2'
      expect(user.aliased_str).to eq(:status2)
      expect(user.aliased_str_raw).to eq('status2')

      user.aliased_int = 1
      expect(user.aliased_int).to eq(:one)
      expect(user.aliased_int_raw).to eq(1)

      user.aliased_flt = 2.0
      expect(user.aliased_flt).to eq(:double)
      expect(user.aliased_flt_raw).to eq(2.0)

      user.aliased_bool = false
      expect(user.aliased_bool).to eq(:false)
      expect(user.aliased_bool_raw).to eq(false)
    end

    it 'assigns nil' do
      user.aliased_str = nil
      expect(user.aliased_str).to eq(nil)
      expect(user.aliased_str_raw).to eq(nil)

      user.aliased_int = nil
      expect(user.aliased_int).to eq(nil)
      expect(user.aliased_int_raw).to eq(nil)

      user.aliased_flt = nil
      expect(user.aliased_flt).to eq(nil)
      expect(user.aliased_flt_raw).to eq(nil)

      user.aliased_bool = nil
      expect(user.aliased_bool).to eq(nil)
      expect(user.aliased_bool_raw).to eq(nil)
    end

    it 'assigns unknown value as it is' do
      user.aliased_str = 'unknown'
      expect(user.aliased_str).to eq('unknown')
      expect(user.aliased_str_raw).to eq('unknown')
    end

    it 'has validation' do
      user.str = 'invalid'
      user.int = -1
      user.flt= -1.0
      user.valid?
      expect(user.errors.keys).to include(:str)
      expect(user.errors.keys).to include(:int)
      expect(user.errors.keys).to include(:flt)
    end

    it 'has scope' do
      expect(user.class.with_str(:status1).count).to be(1)
      expect(user.class.with_aliased_str(:status1).count).to be(1)

      expect(user.class.with_int(0).count).to be(1)
      expect(user.class.with_aliased_int(:zero).count).to be(1)

      expect(user.class.with_flt(0.5).count).to be(1)
      expect(user.class.with_aliased_flt(:half).count).to be(1)

      expect(user.class.with_bool(true).count).to be(1)
      expect(user.class.with_aliased_bool(:true).count).to be(1)
    end

    it 'handles aliased value in where clause' do
      expect(user.class.where(aliased_str: :status1).count).to be(1)
      expect(user.class.where(aliased_int: :zero).count).to be(1)
      expect(user.class.where(aliased_flt: :half).count).to be(1)
      expect(user.class.where(aliased_bool: :true).count).to be(1)
    end

    it 'handles raw value in where clause' do
      expect(user.class.where(aliased_str: 'status1').count).to be(1)
      expect(user.class.where(aliased_int: 0).count).to be(1)
      expect(user.class.where(aliased_flt: 0.5).count).to be(1)
      expect(user.class.where(aliased_bool: true).count).to be(1)
    end

    it 'casts from db value' do
      dbuser = user.class.find_by(aliased_str: :status1)
      expect(dbuser.aliased_str).to be(:status1)
      expect(dbuser.aliased_int).to be(:zero)
      expect(dbuser.aliased_flt).to be(:half)
      expect(dbuser.aliased_bool).to be(:true)
    end
  end
end
