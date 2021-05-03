describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context :string do
        it 'has accessor method' do
          user.aliased_str = :status2
          expect(user.aliased_str).to eq(:status2)
          expect(user.aliased_str_raw).to eq('status2')
        end
      end
    end
  end
end
