module Iesde
  module Api
    class ObterAula < ::Iesde::API
      include Underscorable

      def initialize(format, opts)
        super(:aulas, format, opts)
        @response = "[]" if as_json.is_a?(Hash) && tem_chave?("status") && ( status == false )
      end
    end
  end
end
