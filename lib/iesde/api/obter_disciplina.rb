module Iesde
  module Api
    class ObterDisciplina < ::Iesde::API
      include Underscorable

      def initialize(format, opts)
        super(:disciplinas, format, opts)
      end
    end
  end
end
