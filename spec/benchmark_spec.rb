require 'benchmark'

describe 'dictionary cache benchmark' do
  context 'text method' do
    let(:user) { User.new }

    it 'improves performance' do
      n = 1000
      Benchmark.bmbm do |x|
        x.report("without cache") do
          n.times { user.status_text }
        end
        x.report("with cache (0% hit)") do
          n.times { EnumIsh::DictionaryCache.enable { user.status_text } }
        end
        x.report("with cache (100% hit)") do
          EnumIsh::DictionaryCache.enable { n.times { user.status_text } }
        end
      end
    end
  end

  context 'options method' do
    it 'improves performance' do
      n = 1000
      Benchmark.bmbm do |x|
        x.report("without cache") do
          n.times { User.status_options }
        end
        x.report("with cache (0% hit)") do
          n.times { EnumIsh::DictionaryCache.enable { User.status_options } }
        end
        x.report("with cache (100% hit)") do
          EnumIsh::DictionaryCache.enable { n.times { User.status_options } }
        end
      end
    end
  end
end
