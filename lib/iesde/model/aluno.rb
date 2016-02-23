module Iesde
  module Model
    class Aluno
      attr_accessor :login_aluno, :cpf, :login, :senha

      def initialize(*args)
        @login_aluno, @cpf, @login, @senha = args
      end

      def self.logout params
        client_logout = Iesde::WSDLClient.create :logout
        client_logout.run params
      end

      def logout
        Aluno.logout login: @login, senha: @senha, loginAluno: @login_aluno, cpf: @cpf
      end

    end
  end
end
