describe EnumIsh::ActiveRecordDefiner do
  let(:user) { User.new }

  context :integer do
    it 'has scope' do
      expect(user.class.with_int(0).count).to be(1)
      expect(user.class.with_aliased_int(:zero).count).to be(1)
    end

    it 'has negative scope' do
      expect(user.class.with_int_not(0).count).to be(2)
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
