module Iesde
  module Api
    class AlterarStatusMatricula < ::Iesde::API
      def initialize(format, opts)
        super(:alterar_matricula, format, opts)
      end
    end
  end
end
