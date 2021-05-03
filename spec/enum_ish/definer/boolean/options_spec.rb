describe EnumIsh::Definer do
  user_models.each do |user_model|
    context user_model do
      context :boolean do
        let(:model) {
          test_model(user_model) do
            enum_ish :bool, [true, false]
            enum_ish :aliased_bool, { true: true, false: false }, accessor: true
          end
        }
        let(:user) { model.new }

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
