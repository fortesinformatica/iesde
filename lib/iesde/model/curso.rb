module Iesde
  module Model
    class Curso
      attr_accessor :tipo, :id, :nome, :objetivo, :temas, :autores, :carga_horaria, :valor, :quant_aulas, :categoria, :video_demo, :pdf_demo, :login, :senha
      attr_reader :aulas

      def initialize(*args)
        @tipo, @id, @nome, @objetivo, @temas, @autores, @carga_horaria, @valor, @quant_aulas, @categoria, @video_demo, @pdf_demo = args
      end

      def self.buscar params
        client_busca_curso = WSDLClient.create :lista_curso
        cursos = client_busca_curso.run params
        cursos.each do |curso|
          curso.login = params[:login] 
          curso.senha = params[:senha] 
          curso.tipo = params[:tipo] 
        end
      end

      def aulas
        @aulas ||= buscar_aulas
      end

      private

      def buscar_aulas
        client_obtem_aulas = WSDLClient.create :obtem_aulas
        aulas = client_obtem_aulas.run login: @login, senha: @senha, loginAluno: "", cpf: "", curso: @id, ancora: "", tipo: @tipo
        aulas.each do |aula|
          aula.login = @login
          aula.senha = @senha
          aula.curso = self
        end
      end
    end
  end
end