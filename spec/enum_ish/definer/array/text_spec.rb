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

        it 'has text method' do
          user.array = ['flag1']
          expect(user.array_text).to eq(["フラグ1"])
          user.aliased_array = [:flag1]
          expect(user.aliased_array_text).to eq(["フラグ1"])
        end

        it 'has text method with format' do
          user.array = ['flag1']
          expect(user.array_text(format: :short)).to eq(["f1"])
        end
      end
    end
  end
end
