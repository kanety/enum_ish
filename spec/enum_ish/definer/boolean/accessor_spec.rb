describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context :boolean do
        it 'has accessor method' do
          user.aliased_bool = :false
          expect(user.aliased_bool).to eq(:false)
          expect(user.aliased_bool_raw).to eq(false)
        end
      end
    end
  end
end
