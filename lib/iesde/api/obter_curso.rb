module Iesde
  module Api
    class ObterCurso < ::Iesde::API
      include Underscorable

      def initialize(format, opts)
        super(:cursos, format, opts)
      end
    end
  end
end
