describe EnumIsh::Config do
  context 'config class' do
    around do |example|
      value = EnumIsh.config.text_prefix
      example.run
      EnumIsh.config.text_prefix = value
    end

    it 'gets and sets' do
      EnumIsh.configure do |config|
        config.text_prefix = 'text_'
      end
      expect(EnumIsh.config.text_prefix).to eq('text_')

      EnumIsh.configure do |config|
        config.text_prefix = ''
      end
      expect(EnumIsh.config.text_prefix).to eq('')
    end
  end
end
