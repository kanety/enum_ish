describe EnumIsh::ActiveRecordDefiner do
  context :string do
    let(:model) {
      test_model(User) do
        enum_ish :str, ['status1', 'status2', 'status3'], scope: true
        enum_ish :aliased_str, { status1: 'status1', status2: 'status2', status3: 'status3' }, accessor: true, scope: true
      end
    }
    let(:user) { model.new }

    it 'has scope' do
      expect(user.class.with_str(:status1).count).to be(1)
      expect(user.class.with_aliased_str(:status1).count).to be(1)
    end

    it 'has negative scope' do
      expect(user.class.with_str_not(:status1).count).to be(2)
      expect(user.class.with_aliased_str_not(:status1).count).to be(2)
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
