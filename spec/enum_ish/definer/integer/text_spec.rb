describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context :integer do
        it 'has text method' do
          expect(user.int_text).to eq("整数0")
          expect(user.aliased_int_text).to eq("整数0")
        end

        it 'has text method with format' do
          expect(user.int_text(format: :short)).to eq("0")
        end
      end
    end
  end
end
