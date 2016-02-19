require 'json'

module Iesde
  class Curso
    attr_accessor :tipo, :id, :nome, :objetivo, :temas, :autores, :carga_horaria, :valor, :quant_aulas, :categoria, :video_demo, :pdf_demo

    def initialize(*args)
      @tipo, @id, @nome, @objetivo, @temas, @autores, @carga_horaria, @valor, @quant_aulas, @categoria, @video_demo, @pdf_demo = args
    end

    def self.buscar params
      client_busca_curso = WSDLClient.create :lista_curso
      response = client_busca_curso.run params
      mapeia_cursos response
    end

    private

    def self.mapeia_cursos response
      JSON.parse(response).collect do |item|
        Curso.new *item.values
      end
    end
  end
end