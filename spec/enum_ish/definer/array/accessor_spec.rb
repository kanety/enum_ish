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

        it 'has accessor method' do
          user.aliased_array = [:flag1]
          expect(user.aliased_array).to eq([:flag1])
          expect(user.aliased_array_raw).to eq(['flag1'])
        end
      end
    end
  end
end
