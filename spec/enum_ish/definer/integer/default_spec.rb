describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context :integer do
        it 'has default value' do
          expect(user.int).to eq(0)
        end
      end
    end
  end
end
