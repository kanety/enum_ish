describe EnumIsh::Definer do
  [UserModel].each do |model|
    context model do
      let(:user) { model.new }

      context :array do
        it 'has accessor method' do
          user.aliased_array = [:flag1]
          expect(user.aliased_array).to eq([:flag1])
          expect(user.aliased_array_raw).to eq(['flag1'])
        end
      end
    end
  end
end
