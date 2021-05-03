describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context :boolean do
        it 'has options method' do
          expect(user.class.bool_options).to eq([["真", true], ["偽", false]])
          expect(user.class.aliased_bool_options).to eq([["真", :true], ["偽", :false]])
        end

        it 'has options method with format' do
          expect(user.class.bool_options(format: :short)).to eq([["t", true], ["f", false]])
        end

        it 'has options method with only' do
          expect(user.class.bool_options(only: true)).to eq([["真", true]])
        end

        it 'has options method with except' do
          expect(user.class.bool_options(except: true)).to eq([["偽", false]])
        end
      end
    end
  end
end
