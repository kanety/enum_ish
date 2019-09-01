describe EnumIsh::Config do
  context 'config class' do
    it 'gets config' do
      expect(EnumIsh::Config.text_prefix).to eq('')
    end

    it 'sets config' do
      EnumIsh::Config.configure do |c|
        c.text_prefix = 'text_'
      end
      expect(EnumIsh::Config.text_prefix).to eq('text_')
    end
  end
end
