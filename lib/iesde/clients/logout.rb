module Iesde
  module Clients
    class Logout < Iesde::WSDLClient

      def initialize
        @wsdl_url = "http://ws.videoaulasonline.com.br/index.php/aluno/logout/wsdl"
        @action = "logout"
        @format = [ :login, :senha, :loginAluno, :cpf ]
      end

      def check_params params
        errors = ""
        errors << "[Parâmetros incorretos! formato -> #{@format}]" unless params.keys.eql? @format
        errors << "[Login pode ter no máx 10 digitos]" if params[:login].size > 10
        errors << "[Senha pode ter no máx 32 digitos]" if params[:senha].size > 32
        errors << "[LoginAluno pode ter no máx 100 digitos]" if params[:loginAluno].size > 100
        errors << "[CPF pode ter no máx 11 digitos]" if params[:cpf].size > 11
        errors
      end

      def map response
        ws_message = Iesde::Error::WSError.new(response)
        raise ws_message unless %(027 028).include?(ws_message.code)
        true
      end

      def response_param
        :logout
      end

    end
  end
end