describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context :boolean do
        it 'has text method' do
          expect(user.bool_text).to eq("真")
          expect(user.aliased_bool_text).to eq("真")
        end

        it 'has text method with format' do
          expect(user.bool_text(format: :short)).to eq("t")
        end
      end
    end
  end
end
