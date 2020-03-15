describe EnumIsh::ActiveRecordDefiner do
  let(:user) { User.new }

  context 'string field' do
    it 'has default value' do
      expect(user.str).to eq('status1')
    end

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

    it 'has validation' do
      user.str = 'invalid'
      user.valid?
      expect(user.errors.keys).to include(:str)
    end

    it 'has scope' do
      expect(user.class.with_str(:status1).count).to be(1)
      expect(user.class.with_aliased_str(:status1).count).to be(1)
    end

    it 'handles aliased value in where clause' do
      expect(user.class.where(aliased_str: :status1).count).to be(1)
    end

    it 'handles raw value in where clause' do
      expect(user.class.where(aliased_str: 'status1').count).to be(1)
    end

    it 'casts from db value' do
      dbuser = user.class.find_by(aliased_str: :status1)
      expect(dbuser.aliased_str).to be(:status1)
    end
  end
end
