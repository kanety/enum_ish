describe EnumIsh::Definer do
  user_models.each do |user_model|
    context user_model do
      context :integer do
        let(:model) {
          test_model(user_model) do
            enum_ish :int, [0, 1, 2], predicate: true
            enum_ish :aliased_int, { zero: 0, one: 1, two: 2 }, accessor: true, predicate: true
          end
        }
        let(:user) { model.new }

        it 'has predicate method' do
          user.int = 0
          expect(user.int_0?).to eq(true)
          expect(user.int_1?).to eq(false)
          user.aliased_int = :zero
          expect(user.aliased_int_zero?).to eq(true)
          expect(user.aliased_int_one?).to eq(false)
        end
      end
    end
  end
end
