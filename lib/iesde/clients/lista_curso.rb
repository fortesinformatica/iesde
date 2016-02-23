module Iesde
  module Clients
    class ListaCurso < Iesde::WSDLClient

      def initialize
        @model = Iesde::Model::Curso
        @action = "listaCurso"
        @format = [ :login, :senha, :busca, :tipo, :site, :idCurso ]
        @obligatory_params = [ :login, :senha, :busca, :tipo, :site ]
      end

      def check_params params
        errors = super params
        errors << "[Busca pode ter no máx 100 digitos]" if params[:busca].size > 100
        errors << "[Tipo pode ser uma das letras P, C ou E]" unless ['P','C', 'E'].include?(params[:tipo])
        errors << "[Quando tipo for P precisa especificar idCurso]" if params[:tipo] == 'P' && params[:idCurso].blank?
        errors
      end

    end
  end
end
