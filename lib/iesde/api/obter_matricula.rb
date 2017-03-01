module Iesde
  module Api
    class ObterMatricula < ::Iesde::API 
      def initialize(format)
        super(:matriculas, format)
      include Underscorable
      end
    end
  end
end
