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

        it 'has text method' do
          user.flt = 0.5
          expect(user.flt_text).to eq("0.5倍")
          user.aliased_flt = :half
          expect(user.aliased_flt_text).to eq("0.5倍")
        end

        it 'has text method with format' do
          user.flt = 0.5
          expect(user.flt_text(format: :short)).to eq("0.5")
        end
      end
    end
  end
end
