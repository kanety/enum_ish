describe EnumIsh::DictionaryLookup do
  context 'without option' do
    let :lookup do
      described_class.new(UserModel, UserModel._enum_ish_enums[:status])
    end

    it 'lookups dictionary' do
      expect(lookup.call).to eq("enable" => "有効", "disable" => "無効")
    end
  end

  context 'with format option' do
    let :lookup do
      described_class.new(UserModel, UserModel._enum_ish_enums[:status], format: 'array')
    end

    it 'lookups dictionary' do
      expect(lookup.call).to eq("enable" => ["enable", "有効"], "disable" => ["disable", "無効"])
    end
  end
end
