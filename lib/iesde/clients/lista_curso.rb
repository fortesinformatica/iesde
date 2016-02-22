module Iesde
  module Clients
    class ListaCurso < Iesde::WSDLClient

      def initialize
        @model = Iesde::Model::Curso
        @action = "listaCurso"
        @format = [ :login, :senha, :busca, :tipo, :site, :idCurso ]
      end

      def check_params params
        errors = ""
        errors << "[Parâmetros incorretos! formato -> #{@format}]" unless params.keys.eql? @format
        errors << "[Login pode ter no máx 10 digitos]" if params[:login].size > 10
        errors << "[Senha pode ter no máx 32 digitos]" if params[:senha].size > 32
        errors << "[Busca pode ter no máx 100 digitos]" if params[:busca].size > 100
        errors << "[Tipo pode ser uma das letras P, C ou E]" unless ['P','C', 'E'].include?(params[:tipo])
        errors << "[Quando tipo for P precisa especificar idCurso]" if params[:tipo] == 'P' && params[:idCurso].blank?
        errors
      end

    end
  end
end
