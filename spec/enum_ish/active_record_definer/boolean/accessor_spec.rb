describe EnumIsh::ActiveRecordDefiner do
  let(:user) { User.new }

  context :boolean do
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
  end
end
