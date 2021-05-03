describe EnumIsh::ActiveRecordDefiner do
  let(:user) { User.new }

  context :float do
    it 'has scope' do
      expect(user.class.with_flt(0.5).count).to be(1)
      expect(user.class.with_aliased_flt(:half).count).to be(1)
    end

    it 'has negative scope' do
      expect(user.class.with_flt_not(0.5).count).to be(2)
      expect(user.class.with_aliased_flt_not(:half).count).to be(2)
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
