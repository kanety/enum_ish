describe EnumIsh::Definer do
  user_models.each do |user_model|
    context user_model do
      context :integer do
        let(:model) {
          test_model(user_model) do
            enum_ish :int, [0, 1, 2], default: 0
            enum_ish :aliased_int, { zero: 0, one: 1, two: 2 }, accessor: true, default: :zero
          end
        }
        let(:user) { model.new }

        it 'has default value' do
          expect(user.int).to eq(0)
          expect(user.aliased_int).to eq(:zero)
        end
      end
    end
  end
end
