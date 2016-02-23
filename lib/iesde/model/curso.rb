module Iesde
  module Model
    class Curso
      attr_accessor :tipo, :id, :nome, :objetivo, :temas, :autores, :carga_horaria, :valor, :quant_aulas, :categoria, :video_demo, :pdf_demo, :login, :senha
      attr_reader :aulas, :matriculas

      def initialize(*args)
        @tipo, @id, @nome, @objetivo, @temas, @autores, @carga_horaria, @valor, @quant_aulas, @categoria, @video_demo, @pdf_demo = args
      end

      def self.find params
        curso = nil

        if !params[:id].blank? && !params[:login].blank? && !params[:senha].blank?

          search_params = { login: params[:login], senha: params[:senha], busca: "", tipo: "", site: "", idCurso: params[:id].to_s }

          curso = buscar_cursos_padrao search_params
          curso = buscar_cursos_nos_pacotes search_params unless curso
        end
        return curso
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

      def matriculas
        begin
          @matriculas ||= buscar_matriculas
        rescue Iesde::Error::WSError => e
          if e.code == "010"
            @matriculas = []
          else
            raise e
          end
        end
        @matriculas
      end

      def alunos
        matriculas.map &:aluno
      end

      private

      def self.buscar_cursos_padrao params
        curso = nil
        %w(C E).each do |tipo|
          begin
            params[:tipo] = tipo
            cursos = Curso.buscar params
            if cursos
              curso = cursos.first
              break
            end
          rescue Exception
          end
        end
        curso
      end

      def self.buscar_cursos_nos_pacotes params
        curso = nil
        params[:tipo] = 'P'
        %w(4 22 10 7 6 13).each do |site|
          begin
            params[:site] = site
            cursos = Curso.buscar params
            if cursos
              curso = cursos.first
              break
            end
          rescue Exception
          end
        end
        curso
      end

      def buscar_aulas
        aulas = Aula.buscar login: @login, senha: @senha, loginAluno: "", cpf: "", curso: @id, ancora: "", tipo: @tipo
        passar_dados aulas
      end

      def buscar_matriculas
        matriculas = Matricula.buscar login: @login, senha: @senha, curso: @id, tipo: @tipo
        passar_dados matriculas
      end

      def passar_dados modelos
        modelos.each do |modelo|
          modelo.login = @login
          modelo.senha = @senha
          modelo.curso = self
        end
      end
    end
  end
end
