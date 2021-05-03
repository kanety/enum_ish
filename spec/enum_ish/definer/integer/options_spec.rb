describe EnumIsh::Definer do
  user_models.each do |user_model|
    context user_model do
      context :integer do
        let(:model) {
          test_model(user_model) do
            enum_ish :int, [0, 1, 2]
            enum_ish :aliased_int, { zero: 0, one: 1, two: 2 }, accessor: true
          end
        }
        let(:user) { model.new }

        it 'has options method' do
          expect(user.class.int_options).to eq([["整数0", 0], ["整数1", 1], ["整数2", 2]])
          expect(user.class.aliased_int_options).to eq([["整数0", :zero], ["整数1", :one], ["整数2", :two]])
        end

        it 'has options method with format' do
          expect(user.class.int_options(format: :short)).to eq([["0", 0], ["1", 1], ["2", 2]])
        end

        it 'has options method with only' do
          expect(user.class.int_options(only: 0)).to eq([["整数0", 0]])
        end

        it 'has options method with except' do
          expect(user.class.int_options(except: 0)).to eq([["整数1", 1], ["整数2", 2]])
        end
      end
    end
  end
end
