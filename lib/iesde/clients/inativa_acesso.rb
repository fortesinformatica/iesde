module Iesde
  module Clients
    class InativaAcesso < Iesde::WSDLClient

      CODIGO_RETORNO_SUCESSO = "020"

      def initialize
        @action = "inativaAcesso"
        @format = [ :login, :senha, :"LoginID" ]
        @obligatory_params = [ :login, :senha, :"LoginID" ]
      end

      def map response
        ws_message = Iesde::Error::WSError.new(response)
        raise ws_message if ws_message.code != CODIGO_RETORNO_SUCESSO
        true
      end

    end
  end
end