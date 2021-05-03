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

        it 'has text method' do
          user.str = 'status1'
          expect(user.str_text).to eq("文字列１")
          user.aliased_str = :status1
          expect(user.aliased_str_text).to eq("文字列１")
        end

        it 'has text method with format' do
          user.str = 'status1'
          expect(user.str_text(format: :short)).to eq("文１")
        end
      end
    end
  end
end
