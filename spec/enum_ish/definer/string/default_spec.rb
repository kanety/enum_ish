describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context :string do
        it 'has default value' do
          expect(user.str).to eq('status1')
        end
      end
    end
  end
end
