describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context 'integer field' do
        it 'has text method' do
          expect(user.int_text).to eq("整数0")
          expect(user.aliased_int_text).to eq("整数0")
        end

        it 'has text method with argument' do
          expect(user.int_text(format: :short)).to eq("0")
        end

        it 'has options method' do
          expect(user.class.int_options).to eq([["整数0", 0], ["整数1", 1], ["整数2", 2]])
          expect(user.class.aliased_int_options).to eq([["整数0", :zero], ["整数1", :one], ["整数2", :two]])
        end

        it 'has options method with argument' do
          expect(user.class.int_options(format: :short)).to eq([["0", 0], ["1", 1], ["2", 2]])
          expect(user.class.int_options(only: 0)).to eq([["整数0", 0]])
          expect(user.class.int_options(except: 0)).to eq([["整数1", 1], ["整数2", 2]])
        end
        it 'has predicate method' do
          expect(user.int_0?).to eq(true)
          expect(user.int_1?).to eq(false)
        end

        it 'has default value' do
          expect(user.int).to eq(0)
        end

        it 'has accessor method' do
          user.aliased_int = :one
          expect(user.aliased_int).to eq(:one)
          expect(user.aliased_int_raw).to eq(1)
        end
      end
    end
  end
end
