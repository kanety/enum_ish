describe EnumIsh::Definer do
  user_models.each do |user_model|
    context user_model do
      context :string do
        let(:model) {
          test_model(user_model) do
            enum_ish :str, ['status1', 'status2', 'status3']
            enum_ish :aliased_str, { status1: 'status1', status2: 'status2', status3: 'status3' }, accessor: true
          end
        }
        let(:user) { model.new }

        it 'has accessor method' do
          user.aliased_str = :status2
          expect(user.aliased_str).to eq(:status2)
          expect(user.aliased_str_raw).to eq('status2')
        end
      end
    end
  end
end
