module Iesde
  module Api
    class ObterDadosPdf < ::Iesde::API
      def initialize(format, opts)
        super(:pdf, format, opts)
      end
    end
  end
end
