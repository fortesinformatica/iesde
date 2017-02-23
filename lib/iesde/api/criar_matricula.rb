module Iesde
  module Api
    class CriarMatricula < ::Iesde::API
      def initialize(format, opts)
        super(:cadastro_matricula, format, opts)
      end

      def matricula_id_do_retorno
        as_json["MatriculaID"]
      end
    end
  end
end
