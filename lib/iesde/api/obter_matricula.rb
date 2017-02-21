module Iesde
  module Api
    class ObterMatricula < ::Iesde::API 
      def initialize(format)
        super(:matriculas, format)
      end
    end
  end
end