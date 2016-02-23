module Iesde
  module Model
    class Aula
      attr_accessor :curso_id, :nome_curso, :categoria, :subcategoria, :id, :ordem, :tema, :autores, :duracao, :login_aluno, :cpf, :disciplina_id, :disciplina, :login, :senha, :curso

      def initialize(*args)
        @curso_id, @nome_curso, @categoria, @subcategoria, @id, @ordem, @tema, @autores, @duracao, @login_aluno, @cpf, @disciplina_id, @disciplina = args
      end

      def self.buscar params
        client_obtem_aulas = WSDLClient.create :obtem_aulas
        client_obtem_aulas.run params
      end

      def curso
        @curso ||= Iesde::Model::Curso.find id: @curso_id, login: @login, senha: @senha
      end

    end
  end
end