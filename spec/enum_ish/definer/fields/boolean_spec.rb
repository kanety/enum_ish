describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context 'boolean field' do
        it 'has text method' do
          expect(user.bool_text).to eq("真")
          expect(user.aliased_bool_text).to eq("真")
        end

        it 'has text method with argument' do
          expect(user.bool_text(format: :short)).to eq("t")
        end

        it 'has options method' do
          expect(user.class.bool_options).to eq([["真", true], ["偽", false]])
          expect(user.class.aliased_bool_options).to eq([["真", :true], ["偽", :false]])
        end

        it 'has options method with argument' do
          expect(user.class.bool_options(format: :short)).to eq([["t", true], ["f", false]])
          expect(user.class.bool_options(only: true)).to eq([["真", true]])
          expect(user.class.bool_options(except: true)).to eq([["偽", false]])
        end

        it 'has predicate method' do
          expect(user.bool_true?).to eq(true)
          expect(user.bool_false?).to eq(false)
        end

        it 'has default value' do
          expect(user.bool).to eq(true)
        end

        it 'has accessor method' do
          user.aliased_bool = :false
          expect(user.aliased_bool).to eq(:false)
          expect(user.aliased_bool_raw).to eq(false)
        end
      end
    end
  end
end
