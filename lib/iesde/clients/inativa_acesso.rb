module Iesde
  module Clients
    class InativaAcesso < Iesde::WSDLClient

      def initialize
        @action = "inativaAcesso"
        @format = [ :login, :senha, :"LoginID" ]
      end

      def check_params params
        errors = ""
        errors << "[Parâmetros incorretos! formato -> #{@format}]" unless params.keys.eql? @format
        errors << "[Login pode ter no máx 10 digitos]" if params[:login].size > 10
        errors << "[Senha pode ter no máx 32 digitos]" if params[:senha].size > 32
        errors
      end

      def map response
        ws_message = Iesde::Error::WSError.new(response)
        raise ws_message if ws_message.code != "020"
        true
      end

    end
  end
end