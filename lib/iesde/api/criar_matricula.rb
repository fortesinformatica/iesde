module Iesde
  module Api
    class CriarMatricula < ::Iesde::API 
      def initialize(format, opts)
        super(:cadastro_matricula, format, opts)
      end
    end
  end
end
