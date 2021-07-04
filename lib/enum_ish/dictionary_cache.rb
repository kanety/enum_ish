# frozen_string_literal: true

module EnumIsh
  class DictionaryCache
    def initialize(app)
      @app = app
    end
  
    def call(env)
      EnumIsh::Dictionary.cache do
        @app.call(env)
      end
    end
  end
end
