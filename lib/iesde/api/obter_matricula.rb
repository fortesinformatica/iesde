module Iesde
  module Api
    class ObterMatricula < ::Iesde::API
      include Underscorable

      def initialize(format, config = {})
        super(:matriculas, format, config)
      end
    end
  end
end
