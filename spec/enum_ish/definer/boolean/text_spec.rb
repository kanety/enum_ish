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

        it 'has text method' do
          user.bool = true
          expect(user.bool_text).to eq("真")
          user.aliased_bool = :true
          expect(user.aliased_bool_text).to eq("真")
        end

        it 'has text method with format' do
          user.bool = true
          expect(user.bool_text(format: :short)).to eq("t")
        end
      end
    end
  end
end
