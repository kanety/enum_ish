describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context :string do
        it 'has text method' do
          expect(user.str_text).to eq("文字列１")
          expect(user.aliased_str_text).to eq("文字列１")
        end

        it 'has text method with format' do
          expect(user.str_text(format: :short)).to eq("文１")
        end
      end
    end
  end
end
