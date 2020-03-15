describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context 'float field' do
        it 'has text method' do
          expect(user.flt_text).to eq("0.5倍")
          expect(user.aliased_flt_text).to eq("0.5倍")
        end

        it 'has text method with argument' do
          expect(user.flt_text(format: :short)).to eq("0.5")
        end

        it 'has options method' do
          expect(user.class.flt_options).to eq([["0.5倍", 0.5], ["1倍", 1.0], ["2倍", 2.0]])
          expect(user.class.aliased_flt_options).to eq([["0.5倍", :half], ["1倍", :one], ["2倍", :double]])
        end

        it 'has options method with argument' do
          expect(user.class.flt_options(format: :short)).to eq([["0.5", 0.5], ["1", 1.0], ["2", 2.0]])
          expect(user.class.flt_options(only: 0.5)).to eq([["0.5倍", 0.5]])
          expect(user.class.flt_options(except: 0.5)).to eq([["1倍", 1.0], ["2倍", 2.0]])
        end

        it 'has predicate method' do
          expect(user.flt_0_5?).to eq(true)
          expect(user.flt_1_0?).to eq(false)
        end

        it 'has default value' do
          expect(user.flt).to eq(0.5)
        end

        it 'has accessor method' do
          user.aliased_flt = :double
          expect(user.aliased_flt).to eq(:double)
          expect(user.aliased_flt_raw).to eq(2.0)
        end
      end
    end
  end
end
