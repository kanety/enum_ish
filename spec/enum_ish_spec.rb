describe EnumIsh do
  it 'has a version number' do
    expect(EnumIsh::VERSION).not_to be nil
  end

  context 'simple class' do
    let(:user) { UserModel.new }

    it 'has text method' do
      expect(user.str_text).to eq("文字列１")
      expect(user.int_text).to eq("整数0")
      expect(user.flt_text).to eq("0.5倍")
      expect(user.bool_text).to eq("真")
    end

    it 'has text method for aliased field' do
      expect(user.aliased_str_text).to eq("文字列１")
      expect(user.aliased_int_text).to eq("整数0")
      expect(user.aliased_flt_text).to eq("0.5倍")
      expect(user.aliased_bool_text).to eq("真")
    end

    it 'has options method' do
      expect(User.str_options).to eq([["文字列１", "status1"], ["文字列２", "status2"], ["文字列３", "status3"]])
      expect(User.int_options).to eq([["整数0", 0], ["整数1", 1], ["整数2", 2]])
      expect(User.flt_options).to eq([["0.5倍", 0.5], ["1倍", 1.0], ["2倍", 2.0]])
      expect(User.bool_options).to eq([["真", true], ["偽", false]])
    end

    it 'has options method for aliased field' do
      expect(User.aliased_str_options).to eq([["文字列１", :status1], ["文字列２", :status2], ["文字列３", :status3]])
      expect(User.aliased_int_options).to eq([["整数0", :zero], ["整数1", :one], ["整数2", :two]])
      expect(User.aliased_flt_options).to eq([["0.5倍", :half], ["1倍", :one], ["2倍", :double]])
      expect(User.aliased_bool_options).to eq([["真", :true], ["偽", :false]])
    end

    it 'has text method with format' do
      expect(user.str_text(format: :short)).to eq("文１")
    end

    it 'has options method with format' do
      expect(User.str_options(format: :short)).to eq([["文１", "status1"], ["文２", "status2"], ["文３", "status3"]])
    end

    it 'has options method with only' do
      expect(User.str_options(only: "status1")).to eq([["文字列１", "status1"]])
      expect(User.int_options(only: 0)).to eq([["整数0", 0]])
      expect(User.flt_options(only: 0.5)).to eq([["0.5倍", 0.5]])
      expect(User.bool_options(only: true)).to eq([["真", true]])
    end

    it 'has options method with except' do
      expect(User.str_options(except: "status1")).to eq([["文字列２", "status2"], ["文字列３", "status3"]])
      expect(User.int_options(except: 0)).to eq([["整数1", 1], ["整数2", 2]])
      expect(User.flt_options(except: 0.5)).to eq([["1倍", 1.0], ["2倍", 2.0]])
      expect(User.bool_options(except: true)).to eq([["偽", false]])
    end

    it 'has predicate method' do
      expect(user.str_status1?).to eq(true)
      expect(user.str_status2?).to eq(false)
      expect(user.int_0?).to eq(true)
      expect(user.int_1?).to eq(false)
      expect(user.flt_0_5?).to eq(true)
      expect(user.flt_1_0?).to eq(false)
      expect(user.bool_true?).to eq(true)
      expect(user.bool_false?).to eq(false)
    end

    it 'has default value' do
      expect(user.str).to eq('status1')
      expect(user.int).to eq(0)
      expect(user.flt).to eq(0.5)
      expect(user.bool).to eq(true)
    end

    it 'has accessor method' do
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

    it 'do not have translation' do
      expect(UserModel.no_translation_options).to eq([["val1", "val1"], ["val2", "val2"], ["val3", "val3"]])
    end
  end

  context 'ActiveRecord' do
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
