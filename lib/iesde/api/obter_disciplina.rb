module Iesde
  module Api
    class ObterDisciplina < ::Iesde::API
      def initialize(format)
        super(:disciplinas, format)
      include Underscorable
      end
    end
  end
end
