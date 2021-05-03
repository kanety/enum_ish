describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context :boolean do
        it 'has predicate method' do
          expect(user.bool_true?).to eq(true)
          expect(user.bool_false?).to eq(false)
        end
      end
    end
  end
end
