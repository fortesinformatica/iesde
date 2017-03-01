module Iesde
  module Model
    class Disciplina
      attr_accessor :disciplina_id, :grade_id, :curso_id, :computed, :sigla, :situacao, :carga_horaria, :ementa, :plano_aula

      def initialize(*args)
        @disciplina_id, @grade_id, @curso_id, @computed, @sigla, @situacao, @carga_horaria, @ementa, @plano_aula = args
      end

      def self.buscar
        disciplinas = Iesde::Api::ObterDisciplina.new(:json)

        disciplinas.underscorize_fields(Disciplina)
      end

      def aulas matricula_id
        Iesde::Model::Aula.buscar({
          'MatriculaID'  => matricula_id,
          'DisciplinaID' => disciplina_id
        })
      end

      def dados_pdf matricula_id
        Iesde::Api::ObterDadosPdf.new(:json, {
          'MatriculaID'  => matricula_id,
          'DisciplinaID' => disciplina_id
        }).as_json
      end

      def link_pdf matricula_id, livro_disciplina_id
        Iesde::Api::ObterLinkPdf.new(:json, {
          'MatriculaID'       => matricula_id,
          'LivroDisciplinaID' => livro_disciplina_id
        }).link
      end
    end
  end
end
