describe EnumIsh::Definer do
  [UserModel].each do |user_model|
    context user_model do
      context :array do
        let(:model) {
          test_model(user_model) do
            enum_ish :array, ['flag1', 'flag2'], predicate: true
            enum_ish :aliased_array, { flag1: 'flag1', flag2: 'flag2' }, accessor: true, predicate: true
          end
        }
        let(:user) { model.new }

        it 'has predicate method' do
          user.array = ['flag1']
          expect(user.array_flag1?).to eq(true)
          expect(user.array_flag2?).to eq(false)
          user.aliased_array = [:flag1]
          expect(user.aliased_array_flag1?).to eq(true)
          expect(user.aliased_array_flag2?).to eq(false)
        end
      end
    end
  end
end
