describe EnumIsh::ActiveRecordDefiner do
  let(:user) { User.new }

  context 'integer field' do
    it 'has default value' do
      expect(user.int).to eq(0)
    end

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

    it 'has validation' do
      user.int = -1
      user.valid?
      expect(user.errors.keys).to include(:int)
    end

    it 'has scope' do
      expect(user.class.with_int(0).count).to be(1)
      expect(user.class.with_int_not(0).count).to be(2)
      expect(user.class.with_aliased_int(:zero).count).to be(1)
      expect(user.class.with_aliased_int_not(:zero).count).to be(2)
    end

    it 'handles aliased value in where clause' do
      expect(user.class.where(aliased_int: :zero).count).to be(1)
    end

    it 'handles raw value in where clause' do
      expect(user.class.where(aliased_int: 0).count).to be(1)
    end

    it 'casts from db value' do
      dbuser = user.class.find_by(aliased_str: :status1)
      expect(dbuser.aliased_int).to be(:zero)
    end
  end
end
