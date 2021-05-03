describe EnumIsh::ActiveRecordDefiner do
  context :float do
    let(:model) {
      test_model(User) do
        enum_ish :flt, [0.5, 1.0, 2.0], default: 0.5
        enum_ish :aliased_flt, { half: 0.5, one: 1.0, double: 2.0 }, accessor: true, default: :half
      end
    }
    let(:user) { model.new }

    it 'has default value' do
      expect(user.flt).to eq(0.5)
      expect(user.aliased_flt).to eq(:half)
    end
  end
end
