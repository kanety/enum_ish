describe EnumIsh::Definer do
  context ShortPredicate do
    let(:item) { ShortPredicate.new }

    it 'has short predicate method' do
      expect(item.status1?).to eq(false)
      expect(item.status2?).to eq(false)
    end
  end
end
