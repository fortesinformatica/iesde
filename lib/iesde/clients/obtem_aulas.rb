module Iesde
  module Clients
    class ObtemAula < Iesde::WSDLClient

      def initialize
        @model = Iesde::Model::Aula
        @action = "obtemAulas"
        @format = [ :login, :senha, :loginAluno, :cpf, :curso, :ancora, :tipo ]
        @obligatory_params = [ :login, :senha, :loginAluno, :cpf, :curso, :tipo ]
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
