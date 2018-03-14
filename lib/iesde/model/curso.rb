module Iesde
  module Model
    class Curso
      # include Stringable

      # attr_accessor :alternativa_id, :texto, :correta, :questao_id

      def initialize(*args)
      end

      def self.buscar(opts = {})
        Iesde::Api::ObterCurso.new(:json, opts)
      end
    end
  end
end


# {
# "CursoID\":\"105705\",
# \"Situacao\":\"A\",
# \"Nome\":\"SOCIOLOGIA POL\\u00cdTICA - FORTES TECNOLOGIA EM SISTEMAS LTDA - 6 MESES\",
# \"DescricaoCertificado\":\"SOCIOLOGIA POL\\u00cdTICA\",
# \"DuracaoMeses\":\"6\",
# \"MaterialDidatico\":\"N\",
# \"ImprimirTermo\":\"N\",
# \"GerarKitMatricula\":\"N\",
# \"ImprimirTermoOnline\":\"N\",
# \"ImprimirBoleto\":\"N\",
# \"ImprimirGenerico\":\"N\",
# \"CampanhaComercial\":\"N\",
# \"CategoriaID\":\"12\",
# \"Categoria\":\"CURSOS SEM CATEGORIA\",
# \"ProjCategoriaID\":\"10\",
# \"ProjCategoria\":\"DISCIPLINA ISOLADA\",
# \"ProjSubCategoriaID\":\"5\",
# \"ProjSubCategoria\":\"EDUCA\\u00c7\\u00c3O\"
# }
