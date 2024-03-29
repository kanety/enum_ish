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

        it 'has options method' do
          expect(user.class.str_options).to eq([["文字列１", "status1"], ["文字列２", "status2"], ["文字列３", "status3"]])
          expect(user.class.aliased_str_options).to eq([["文字列１", :status1], ["文字列２", :status2], ["文字列３", :status3]])
        end

        it 'has options method with format' do
          expect(user.class.str_options(format: :short)).to eq([["文１", "status1"], ["文２", "status2"], ["文３", "status3"]])
        end

        it 'has options method with only' do
          expect(user.class.str_options(only: "status1")).to eq([["文字列１", "status1"]])
        end

        it 'has options method with except' do
          expect(user.class.str_options(except: "status1")).to eq([["文字列２", "status2"], ["文字列３", "status3"]])
        end
      end
    end
  end
end
