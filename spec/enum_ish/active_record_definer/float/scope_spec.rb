describe EnumIsh::ActiveRecordDefiner do
  context :float do
    let(:model) {
      test_model(User) do
        enum_ish :flt, [0.5, 1.0, 2.0], scope: true
        enum_ish :aliased_flt, { half: 0.5, one: 1.0, double: 2.0 }, accessor: true, scope: true
      end
    }
    let(:user) { model.new }

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
