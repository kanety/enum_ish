describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context :float do
        it 'has predicate method' do
          expect(user.flt_0_5?).to eq(true)
          expect(user.flt_1_0?).to eq(false)
        end
      end
    end
  end
end
