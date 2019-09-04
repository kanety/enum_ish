describe EnumIsh::Config do
  context 'config class' do
    it 'gets and sets' do
      EnumIsh::Config.configure do |c|
        c.text_prefix = 'text_'
      end
      expect(EnumIsh::Config.text_prefix).to eq('text_')

      EnumIsh::Config.configure do |c|
        c.text_prefix = ''
      end
      expect(EnumIsh::Config.text_prefix).to eq('')
    end
  end
end
