describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context :float do
        it 'has options method' do
          expect(user.class.flt_options).to eq([["0.5倍", 0.5], ["1倍", 1.0], ["2倍", 2.0]])
          expect(user.class.aliased_flt_options).to eq([["0.5倍", :half], ["1倍", :one], ["2倍", :double]])
        end

        it 'has options method with format' do
          expect(user.class.flt_options(format: :short)).to eq([["0.5", 0.5], ["1", 1.0], ["2", 2.0]])
        end

        it 'has options method with only' do
          expect(user.class.flt_options(only: 0.5)).to eq([["0.5倍", 0.5]])
        end

        it 'has options method with except' do
          expect(user.class.flt_options(except: 0.5)).to eq([["1倍", 1.0], ["2倍", 2.0]])
        end
      end
    end
  end
end
