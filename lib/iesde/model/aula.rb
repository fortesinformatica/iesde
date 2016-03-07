module Iesde
  module Model
    class Aula
      attr_accessor :curso_id, :nome_curso, :categoria, :subcategoria, :id, :ordem, :tema, :autores, :duracao, :login_aluno, :cpf, :disciplina_id, :disciplina, :login, :senha, :curso

      def initialize(*args)
        @curso_id, @nome_curso, @categoria, @subcategoria, @id, @ordem, @tema, @autores, @duracao, @login_aluno, @cpf, @disciplina_id, @disciplina = args
      end

      def self.buscar params
        client_obtem_aulas = WSDLClient.create :obtem_aulas
        aulas = client_obtem_aulas.run params
        aulas.each do |aula|
          aula.login = params[:login]
          aula.senha = params[:senha]
        end
      end

      def curso
        @curso ||= Curso.find id: @curso_id, login: @login, senha: @senha
      end

      def link_pdf email_aluno, cpf_aluno
        client_buscar_arquivo = WSDLClient.create :buscararquivo
        client_buscar_arquivo.run usuario: email_aluno, senha: cpf_aluno, curso: @curso_id, aula: @id, tipo: curso.tipo
      end

      def pdf_para aluno
        link_pdf aluno.login_aluno, aluno.cpf
      end

    end
  end
end
