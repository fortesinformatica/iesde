module Iesde
  module Api
    class ObterDisciplina < ::Iesde::API
      def initialize(format)
        super(:disciplinas, format)
      end
    end
  end
end
