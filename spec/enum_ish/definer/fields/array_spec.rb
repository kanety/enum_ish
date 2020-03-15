describe EnumIsh::Definer do
  [UserModel].each do |model|
    context model do
      let(:user) { model.new }

      context 'array field' do
        it 'has text method' do
          expect(user.array_text).to eq(["フラグ1"])
          expect(user.aliased_array_text).to eq(["フラグ1"])
        end

        it 'has text method with argument' do
          expect(user.array_text(format: :short)).to eq(["f1"])
        end

        it 'has options method' do
          expect(user.class.array_options).to eq([["フラグ1", "flag1"], ["フラグ2", "flag2"]])
          expect(user.class.aliased_array_options).to eq([["フラグ1", :flag1], ["フラグ2", :flag2]])
        end

        it 'has options method with argument' do
          expect(user.class.array_options(format: :short)).to eq([["f1", "flag1"], ["f2", "flag2"]])
          expect(user.class.array_options(only: "flag1")).to eq([["フラグ1", "flag1"]])
          expect(user.class.array_options(except: "flag1")).to eq([["フラグ2", "flag2"]])
        end

        it 'has predicate method' do
          expect(user.array_flag1?).to eq(true)
          expect(user.array_flag2?).to eq(false)
        end

        it 'has default value' do
          expect(user.array).to eq(['flag1'])
        end

        it 'has accessor method' do
          user.aliased_array = [:flag1]
          expect(user.aliased_array).to eq([:flag1])
          expect(user.aliased_array_raw).to eq(['flag1'])
        end
      end
    end
  end
end
