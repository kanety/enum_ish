describe EnumIsh::Definer do
  user_models.each do |user_model|
    context user_model do
      context :string do
        let(:model) {
          test_model(user_model) do
            enum_ish :str, ['status1', 'status2', 'status3'], default: 'status1'
            enum_ish :aliased_str, { status1: 'status1', status2: 'status2', status3: 'status3' }, accessor: true, default: :status1
          end
        }
        let(:user) { model.new }

        it 'has default value' do
          expect(user.str).to eq('status1')
          expect(user.aliased_str).to eq(:status1)
        end
      end
    end
  end
end
