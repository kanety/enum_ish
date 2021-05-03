describe EnumIsh::Definer do
  user_models.each do |user_model|
    context user_model do
      context :boolean do
        let(:model) {
          test_model(user_model) do
            enum_ish :bool, [true, false]
            enum_ish :aliased_bool, { true: true, false: false }, accessor: true
          end
        }
        let(:user) { model.new }

        it 'has accessor method' do
          user.aliased_bool = :false
          expect(user.aliased_bool).to eq(:false)
          expect(user.aliased_bool_raw).to eq(false)
        end
      end
    end
  end
end
