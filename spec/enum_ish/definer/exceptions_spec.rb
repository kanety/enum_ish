describe EnumIsh::Definer do
  context 'no translations' do
    let(:model) {
      test_model(Class.new) do
        include EnumIsh::Base
        attr_accessor :value
        enum_ish :value, ['val1', 'val2', 'val3']
      end
    }

    it 'returns text' do
      item = model.new
      item.value = 'val1'
      expect(item.value_text).to eq('val1')
    end

    it 'returns options' do
      expect(model.value_options).to eq([["val1", "val1"], ["val2", "val2"], ["val3", "val3"]])
    end
  end

  context 'translation with same label' do
    let(:model) {
      test_model(UserModel) do
        attr_accessor :same_label_value
        enum_ish :same_label_value, ['val1', 'val2']
      end
    }

    it 'returns text' do
      item = model.new
      item.same_label_value = 'val1'
      expect(item.same_label_value_text).to eq('label')
    end

    it 'returns options' do
      expect(model.same_label_value_options).to eq([['label', 'val1'],['label', 'val2']])
    end
  end

  context 'scope in plain model' do
    it 'raises errors' do
      expect {
        UserModel.class_eval do
          attr_accessor :scope_value
          enum_ish :scope_value, [1, 2], scope: true
        end
      }.to raise_error(EnumIsh::Error)
    end
  end
end
