module Iesde
  module Model
    class Disciplina
      include Stringable

      attr_accessor :disciplina_id, :grade_id, :curso_id, :computed, :sigla, :situacao, :carga_horaria, :ementa, :plano_aula

      def initialize(*args)
        @disciplina_id, @grade_id, @curso_id, @computed, @sigla, @situacao, @carga_horaria, @ementa, @plano_aula = args
      end

      def self.buscar(opts = {})
        disciplinas = Iesde::Api::ObterDisciplina.new(:json, opts)

        disciplinas.underscorize_fields(Disciplina)
      end

      def aulas(matricula_id, opts = {})
        Iesde::Model::Aula.buscar({
          'MatriculaID'  => matricula_id,
          'DisciplinaID' => disciplina_id
        }.merge(opts))
      end

      def dados_pdf(matricula_id, opts = {})
        Iesde::Api::ObterDadosPdf.new(:json, {
          'MatriculaID'  => matricula_id,
          'DisciplinaID' => disciplina_id
        }.merge(opts)).as_json
      end

      def link_pdf(matricula_id, livro_disciplina_id, opts = {})
        Iesde::Api::ObterLinkPdf.new(:json, {
          'MatriculaID'       => matricula_id,
          'LivroDisciplinaID' => livro_disciplina_id
        }.merge(opts)).link
      end

      def pdf(matricula_id, opts = {})
        livro_disciplina_id = dados_pdf(matricula_id, opts).first["LivroDisciplinaID"]
        link_pdf(matricula_id, livro_disciplina_id, opts)
      end
    end
  end
end
