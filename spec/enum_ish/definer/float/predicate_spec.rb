describe EnumIsh::Definer do
  user_models.each do |user_model|
    context user_model do
      context :float do
        let(:model) {
          test_model(user_model) do
            enum_ish :flt, [0.5, 1.0, 2.0], predicate: true
            enum_ish :aliased_flt, { half: 0.5, one: 1.0, double: 2.0 }, accessor: true, predicate: true
          end
        }
        let(:user) { model.new }

        it 'has predicate method' do
          user.flt = 0.5
          expect(user.flt_0_5?).to eq(true)
          expect(user.flt_1_0?).to eq(false)
          user.aliased_flt = :half
          expect(user.aliased_flt_half?).to eq(true)
          expect(user.aliased_flt_one?).to eq(false)
        end
      end
    end
  end
end
