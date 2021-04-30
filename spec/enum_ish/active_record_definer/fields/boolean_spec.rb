describe EnumIsh::ActiveRecordDefiner do
  let(:user) { User.new }

  context 'boolean field' do
    it 'has default value' do
      expect(user.bool).to eq(true)
    end

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

    it 'has scope' do
      expect(user.class.with_bool(true).count).to be(1)
      expect(user.class.with_bool_not(true).count).to be(2)
      expect(user.class.with_aliased_bool(:true).count).to be(1)
      expect(user.class.with_aliased_bool_not(:true).count).to be(2)
    end

    it 'handles aliased value in where clause' do
      expect(user.class.where(aliased_bool: :true).count).to be(1)
    end

    it 'handles raw value in where clause' do
      expect(user.class.where(aliased_bool: true).count).to be(1)
    end

    it 'casts from db value' do
      dbuser = user.class.find_by(aliased_str: :status1)
      expect(dbuser.aliased_bool).to be(:true)
    end
  end
end
