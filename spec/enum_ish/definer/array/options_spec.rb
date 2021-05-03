describe EnumIsh::Definer do
  [UserModel].each do |model|
    context model do
      let(:user) { model.new }

      context :array do
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
