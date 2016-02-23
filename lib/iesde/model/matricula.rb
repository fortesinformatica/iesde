module Iesde
  module Model
    class Matricula
      attr_accessor :curso_id, :nome_curso, :data_inclusao, :duracao, :email_aluno, :cpf_aluno, :id, :login, :senha, :curso

      def initialize(*args)
        @curso_id, @nome_curso, @data_inclusao, @duracao, @email_aluno, @cpf_aluno, @id = args
      end

      def self.buscar params
        client_obtem_matriculas = WSDLClient.create :obtem_matriculas
        matriculas = client_obtem_matriculas.run params
        matriculas.each do |matricula|
          matricula.login = params[:login]
          matricula.senha = params[:senha]
        end
      end

      def self.criar params
        client_cadastro = WSDLClient.create :cadastro
        if client_cadastro.run(params)
          matriculas = buscar params.except(:loginAluno, :cpf, :duracao, :valor)
          matriculas.select { |matricula| matricula.email_aluno == params[:loginAluno] }
        end
      end

      def curso
        @curso ||= Curso.find id: @curso_id, login: @login, senha: @senha
      end

    end
  end
end
