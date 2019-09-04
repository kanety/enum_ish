describe EnumIsh::Definer do
  context 'other specs' do
    it 'returns value as label if there are no translations' do
      expect(Other.no_translation_options).to eq([["val1", "val1"], ["val2", "val2"], ["val3", "val3"]])
    end

    it 'returns options with same label' do
      expect(Other.same_label_options).to eq([['label', 'value1'],['label', 'value2']])
    end

    it 'raises errors if scope is used for non ActiveRecord' do
      expect {
        Other.class_eval do
          attr_accessor :scope_attr
          enum_ish :scope_attr, [1, 2], scope: true
        end
      }.to raise_error(EnumIsh::Error)
    end
  end
end
