describe EnumIsh::ActiveRecordDefiner do
  context :integer do
    let(:model) {
      test_model(User) do
        enum_ish :int, [0, 1, 2], scope: true
        enum_ish :aliased_int, { zero: 0, one: 1, two: 2 }, accessor: true, scope: true
      end
    }
    let(:user) { model.new }

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
