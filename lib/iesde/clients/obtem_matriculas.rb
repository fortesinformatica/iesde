module Iesde
  module Clients
    class ObtemMatricula < Iesde::API

      CODIGO_RETORNO_NENHUMA_ENCONTRADA = "010"

      def initialize
        @model = Iesde::Model::Matricula
        @action = "obtemMatriculas"
        @format = [ :login, :senha, :curso, :tipo ]
        
      end

      def check_params params
        errors = super params
        errors << "[Curso pode ter no máx 6 digitos]" if params[:curso].size > 6
        errors << "[Tipo pode ser uma das letras P, C ou E]" unless ['P','C', 'E'].include?(params[:tipo])
        errors
      end

    end
  end
end
