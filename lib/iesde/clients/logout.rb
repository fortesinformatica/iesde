module Iesde
  module Clients
    class Logout < Iesde::WSDLClient

      CODIGO_RETORNO_LOGOUT_JA_REALIZADO = "027"
      CODIGO_RETORNO_LOGOUT_REALIZADO = "028"

      def initialize
        @wsdl_url = "http://ws.videoaulasonline.com.br/index.php/aluno/logout/wsdl"
        @action = "logout"
        @format = [ :login, :senha, :loginAluno, :cpf ]
        @obligatory_params = [ :login, :senha, :loginAluno, :cpf ]
      end

      def check_params params
        errors = super params
        errors << "[LoginAluno pode ter no máx 100 digitos]" if params[:loginAluno].size > 100
        errors << "[CPF pode ter no máx 11 digitos]" if params[:cpf].size > 11
        errors
      end

      def map response
        ws_message = Iesde::Error::WSError.new(response)
        raise ws_message unless [CODIGO_RETORNO_LOGOUT_JA_REALIZADO, CODIGO_RETORNO_LOGOUT_REALIZADO].include?(ws_message.code)
        true
      end

      def response_param
        :logout
      end

    end
  end
end