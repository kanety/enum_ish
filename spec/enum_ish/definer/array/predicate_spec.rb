describe EnumIsh::Definer do
  [UserModel].each do |model|
    context model do
      let(:user) { model.new }

      context :array do
        it 'has predicate method' do
          expect(user.array_flag1?).to eq(true)
          expect(user.array_flag2?).to eq(false)
        end
      end
    end
  end
end
