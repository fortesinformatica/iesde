module Iesde
  module Api
    class ObterAula < ::Iesde::API
      def initialize(format, opts)
        super(:aulas, format, opts)
      end
    end
  end
end
