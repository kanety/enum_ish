describe EnumIsh::Definer do
  user_models.each do |model|
    context model do
      let(:user) { model.new }

      context :float do
        it 'has accessor method' do
          user.aliased_flt = :double
          expect(user.aliased_flt).to eq(:double)
          expect(user.aliased_flt_raw).to eq(2.0)
        end
      end
    end
  end
end
