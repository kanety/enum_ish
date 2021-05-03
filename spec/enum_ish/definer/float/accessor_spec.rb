describe EnumIsh::Definer do
  user_models.each do |user_model|
    context user_model do
      context :float do
        let(:model) {
          test_model(user_model) do
            enum_ish :flt, [0.5, 1.0, 2.0]
            enum_ish :aliased_flt, { half: 0.5, one: 1.0, double: 2.0 }, accessor: true
          end
        }
        let(:user) { model.new }

        it 'has accessor method' do
          user.aliased_flt = :double
          expect(user.aliased_flt).to eq(:double)
          expect(user.aliased_flt_raw).to eq(2.0)
        end
      end
    end
  end
end
