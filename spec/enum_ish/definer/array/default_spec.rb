describe EnumIsh::Definer do
  [UserModel].each do |model|
    context model do
      let(:user) { model.new }

      context :array do
        it 'has default value' do
          expect(user.array).to eq(['flag1'])
        end
      end
    end
  end
end
