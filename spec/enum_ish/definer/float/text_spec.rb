describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context :float do
        it 'has text method' do
          expect(user.flt_text).to eq("0.5倍")
          expect(user.aliased_flt_text).to eq("0.5倍")
        end

        it 'has text method with format' do
          expect(user.flt_text(format: :short)).to eq("0.5")
        end
      end
    end
  end
end
