describe EnumIsh::Definer do
  user_models.each do |user_model|
    context user_model do
      context :boolean do
        let(:model) {
          test_model(user_model) do
            enum_ish :bool, [true, false], predicate: true
            enum_ish :aliased_bool, { true: true, false: false }, accessor: true, predicate: true
          end
        }
        let(:user) { model.new }

        it 'has predicate method' do
          user.bool = true
          expect(user.bool_true?).to eq(true)
          expect(user.bool_false?).to eq(false)
          user.aliased_bool = :true
          expect(user.aliased_bool_true?).to eq(true)
          expect(user.aliased_bool_false?).to eq(false)
        end
      end
    end
  end
end
