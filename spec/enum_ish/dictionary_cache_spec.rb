describe EnumIsh::DictionaryCache do
  it 'translates options' do
    EnumIsh::Dictionary.cache do
      expect(User.status_options).to eq([["有効", "enable"], ["無効", "disable"]])
      expect(User.status_options(format: :short)).to eq([["有", "enable"], ["無", "disable"]])
    end
  end

  context 'middleware' do
    let :app do
      Class.new do
        def initialize
        end

        def call(env)
          User.status_options
        end
      end
    end

    let :middleware do
      EnumIsh::DictionaryCache.new(app.new)
    end

    it 'translates options' do
      expect(middleware.call({})).to eq([["有効", "enable"], ["無効", "disable"]])
    end
  end
end
