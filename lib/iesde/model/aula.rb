module Iesde
  module Model
    class Aula
      attr_accessor :matricula_id, :curso_id, :grade_id, :disciplina_id, :aula_id, :tema

      def initialize(*args)
        @matricula_id, @curso_id, @grade_id, @disciplina_id, @aula_id, @tema = args
      end

      def self.buscar opts
        aulas = Iesde::Api::ObterAula.new(:json, opts)

        aulas.as_json.map do |disc|
          params = {}
          disc.map { |k,v| params[k.underscore.to_sym] = v }

          Aula.new(*params.values)
        end
      end

      def link_video
        video = Iesde::Api::ObterVideo.new(:json, {
          'MatriculaID' => matricula_id,
          'AulaID'      => aula_id
        }).link
      end
    end
  end
end
