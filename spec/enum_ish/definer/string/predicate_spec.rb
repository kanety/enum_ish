describe EnumIsh::Definer do
  user_models.each do |user_model|
    context user_model do
      context :string do
        let(:model) {
          test_model(user_model) do
            enum_ish :str, ['status1', 'status2', 'status3'], predicate: true
            enum_ish :aliased_str, { status1: 'status1', status2: 'status2', status3: 'status3' }, accessor: true, predicate: true
          end
        }
        let(:user) { model.new }

        it 'has predicate method' do
          user.str = 'status1'
          expect(user.str_status1?).to eq(true)
          expect(user.str_status2?).to eq(false)
          user.aliased_str = :status1
          expect(user.aliased_str_status1?).to eq(true)
          expect(user.aliased_str_status2?).to eq(false)
        end
      end

      context :string do
        let(:model) {
          test_model(user_model) do
            enum_ish :str, ['status1', 'status2', 'status3'], predicate: { prefix: false }
          end
        }
        let(:user) { model.new }

        it 'has short predicate method' do
          user.str = 'status1'
          expect(user.status1?).to eq(true)
          expect(user.status2?).to eq(false)
        end
      end
    end
  end
end
