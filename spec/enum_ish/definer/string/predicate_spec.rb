describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context :string do
        it 'has predicate method' do
          expect(user.str_status1?).to eq(true)
          expect(user.str_status2?).to eq(false)
        end
      end
    end
  end
end
