describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context :integer do
        it 'has accessor method' do
          user.aliased_int = :one
          expect(user.aliased_int).to eq(:one)
          expect(user.aliased_int_raw).to eq(1)
        end
      end
    end
  end
end
