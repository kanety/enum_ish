describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context :integer do
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
