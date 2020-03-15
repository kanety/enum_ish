describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context 'string field' do
        it 'has text method' do
          expect(user.str_text).to eq("文字列１")
          expect(user.aliased_str_text).to eq("文字列１")
        end

        it 'has text method with argument' do
          expect(user.str_text(format: :short)).to eq("文１")
        end
  
        it 'has options method' do
          expect(user.class.str_options).to eq([["文字列１", "status1"], ["文字列２", "status2"], ["文字列３", "status3"]])
          expect(user.class.aliased_str_options).to eq([["文字列１", :status1], ["文字列２", :status2], ["文字列３", :status3]])
        end

        it 'has options method with argument' do
          expect(user.class.str_options(format: :short)).to eq([["文１", "status1"], ["文２", "status2"], ["文３", "status3"]])
          expect(user.class.str_options(only: "status1")).to eq([["文字列１", "status1"]])
          expect(user.class.str_options(except: "status1")).to eq([["文字列２", "status2"], ["文字列３", "status3"]])
        end

        it 'has predicate method' do
          expect(user.str_status1?).to eq(true)
          expect(user.str_status2?).to eq(false)
        end

        it 'has default value' do
          expect(user.str).to eq('status1')
        end

        it 'has accessor method' do
          user.aliased_str = :status2
          expect(user.aliased_str).to eq(:status2)
          expect(user.aliased_str_raw).to eq('status2')
        end
      end
    end
  end
end
