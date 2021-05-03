describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context :integer do
        it 'has predicate method' do
          expect(user.int_0?).to eq(true)
          expect(user.int_1?).to eq(false)
        end
      end
    end
  end
end
