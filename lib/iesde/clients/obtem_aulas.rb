module Iesde
  module Clients
    class ObtemAula < Iesde::WSDLClient

      def initialize
        @model = Iesde::Model::Aula
        @action = "obtemAulas"
        @format = [ :login, :senha, :loginAluno, :cpf, :curso, :ancora, :tipo ]
      end

      def check_params params
        errors = ""
        errors << "[Parâmetros incorretos! formato -> #{@format}]" unless params.keys.eql? @format
        errors << "[Login pode ter no máx 10 digitos]" if params[:login].size > 10
        errors << "[Senha pode ter no máx 32 digitos]" if params[:senha].size > 32
        errors << "[Curso pode ter no máx 6 digitos]" if params[:curso].size > 6
        errors << "[Tipo pode ser uma das letras P, C ou E]" unless ['P','C', 'E'].include?(params[:tipo])
        errors
      end

    end
  end
end
