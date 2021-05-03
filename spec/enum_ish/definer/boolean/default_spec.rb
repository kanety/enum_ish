describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context :boolean do
        it 'has default value' do
          expect(user.bool).to eq(true)
        end
      end
    end
  end
end
