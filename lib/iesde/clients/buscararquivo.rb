module Iesde
  module Clients
    class Buscararquivo < Iesde::WSDLClient

      def initialize
        @action = "buscararquivo"
        @wsdl_url = "http://ws.videoaulasonline.com.br/index.php/pdf/buscararquivo/wsdl"
        @format = [ :usuario, :senha, :curso, :aula, :tipo ]
        @obligatory_params = [ :usuario, :senha, :curso, :aula, :tipo ]
      end

      def check_params params
        errors = ""
        errors << "[E-mail pode ter no máx 100 digitos]" if params[:usuario].size > 100
        errors << "[CPF pode ter no máx 11 digitos]" if params[:senha].size > 11
        errors << "[Curso pode ter no máx 6 digitos]" if params[:curso].size > 6
        errors << "[Aula pode ter no máx 6 digitos]" if params[:aula].size > 6
        errors << "[Tipo pode ser uma das letras P, C ou E]" unless ['P','C', 'E'].include?(params[:tipo])
        errors
      end

      def map response
        response.gsub("\"","")
      end

    end
  end
end
