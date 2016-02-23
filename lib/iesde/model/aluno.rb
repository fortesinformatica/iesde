module Iesde
  module Model
    class Aluno
      attr_accessor :login_aluno, :cpf, :login, :senha

      def initialize(*args)
        @login_aluno, @cpf = args
      end

      def self.logout params
        client_logout = Iesde::WSDLClient.create :logout
        client_logout.run params
      end

    end
  end
end
