describe EnumIsh::DictionaryCache do
  context 'with cache' do
    let :app do
      Class.new do
        def initialize
        end
      
        def call(env)
          User.status_options
        end
      end
    end

    let(:middleware) do
      EnumIsh::DictionaryCache.new(app.new)
    end

    it 'resolves options' do
      expect(middleware.call({})).to eq([["有効", "enable"], ["無効", "disable"]])
    end
  end
end
