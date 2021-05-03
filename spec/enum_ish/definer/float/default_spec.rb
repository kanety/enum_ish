describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context :float do
        it 'has default value' do
          expect(user.flt).to eq(0.5)
        end
      end
    end
  end
end
