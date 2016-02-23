module Iesde
  module Clients
    class Cadastro < Iesde::WSDLClient

      CODIGO_RETORNO_SUCESSO = "001"

      def initialize
        @action = "Cadastro"
        @wsdl_url = "http://ws.videoaulasonline.com.br/aluno/cadastro/wsdl"
        @format = [ :login, :senha, :loginAluno, :cpf, :curso, :duracao, :tipo, :valor ]
        @obligatory_params = [ :login, :senha, :loginAluno, :cpf, :curso, :duracao, :tipo ]
      end

      def check_params params
        errors = super params
        errors << "[LoginAluno pode ter no máx 100 digitos]" if params[:loginAluno].size > 100
        errors << "[CPF pode ter no máx 11 digitos]" if params[:cpf].size > 11
        errors << "[Curso pode ter no máx 6 digitos]" if params[:curso].size > 6
        errors << "[Duracao precisa ser múltiplo de 30 dias e ter no máx 4 dígitos]" if params[:duracao].to_s.size > 4 || params[:duracao].to_i % 30 != 0
        errors << "[Tipo pode ser uma das letras P, C ou E]" unless ['P','C', 'E'].include?(params[:tipo])
        errors
      end

      def map response
        ws_message = Iesde::Error::WSError.new(response)
        raise ws_message if ws_message.code != CODIGO_RETORNO_SUCESSO
        true
      end

    end
  end
end
