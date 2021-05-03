describe EnumIsh::Definer do
  user_models.each do |user_model|
    context user_model do
      context :integer do
        let(:model) {
          test_model(user_model) do
            enum_ish :int, [0, 1, 2]
            enum_ish :aliased_int, { zero: 0, one: 1, two: 2 }, accessor: true
          end
        }
        let(:user) { model.new }

        it 'has text method' do
          user.int = 0
          expect(user.int_text).to eq("整数0")
          user.aliased_int = :zero
          expect(user.aliased_int_text).to eq("整数0")
        end

        it 'has text method with format' do
          user.int = 0
          expect(user.int_text(format: :short)).to eq("0")
        end
      end
    end
  end
end
