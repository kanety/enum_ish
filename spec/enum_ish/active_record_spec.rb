describe EnumIsh::Definer::ActiveRecord do
  context 'ActiveRecord class' do
    let(:user) { User.new }

    it 'with default value' do
      expect(user.str).to eq('status1')
      expect(user.int).to eq(0)
      expect(user.flt).to eq(0.5)
      expect(user.bool).to eq(true)
    end

    it 'with accessor method' do
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

    it 'with validation' do
      user.str = 'invalid'
      user.int = -1
      user.flt= -1.0
      user.valid?
      expect(user.errors.keys).to include(:str)
      expect(user.errors.keys).to include(:int)
      expect(user.errors.keys).to include(:flt)
    end

    it 'with scope' do
      expect(User.with_str(:status1).count).to be(0)
      expect(User.with_aliased_str(:status1).count).to be(0)

      expect(User.with_int(0).count).to be(0)
      expect(User.with_aliased_int(:zero).count).to be(0)

      expect(User.with_flt(0.5).count).to be(0)
      expect(User.with_aliased_flt(:half).count).to be(0)

      expect(User.with_bool(true).count).to be(0)
      expect(User.with_aliased_bool(:true).count).to be(0)
    end
  end
end
