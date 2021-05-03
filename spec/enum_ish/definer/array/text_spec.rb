describe EnumIsh::Definer do
  [UserModel].each do |model|
    context model do
      let(:user) { model.new }

      context :array do
        it 'has text method' do
          expect(user.array_text).to eq(["フラグ1"])
          expect(user.aliased_array_text).to eq(["フラグ1"])
        end

        it 'has text method with format' do
          expect(user.array_text(format: :short)).to eq(["f1"])
        end
      end
    end
  end
end
