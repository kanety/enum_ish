describe EnumIsh::Definer do
  [UserModel].each do |user_model|
    context user_model do
      context :array do
        let(:model) {
          test_model(user_model) do
            enum_ish :array, ['flag1', 'flag2']
            enum_ish :aliased_array, { flag1: 'flag1', flag2: 'flag2' }, accessor: true
          end
        }
        let(:user) { model.new }

        it 'has options method' do
          expect(user.class.array_options).to eq([["フラグ1", "flag1"], ["フラグ2", "flag2"]])
          expect(user.class.aliased_array_options).to eq([["フラグ1", :flag1], ["フラグ2", :flag2]])
        end

        it 'has options method with format' do
          expect(user.class.array_options(format: :short)).to eq([["f1", "flag1"], ["f2", "flag2"]])
        end

        it 'has options method with only' do
          expect(user.class.array_options(only: "flag1")).to eq([["フラグ1", "flag1"]])
        end

        it 'has options method with except' do
          expect(user.class.array_options(except: "flag1")).to eq([["フラグ2", "flag2"]])
        end
      end
    end
  end
end
