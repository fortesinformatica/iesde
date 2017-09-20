module Iesde
  module Api
    class ObterAlternativas < ::Iesde::API
      include Underscorable

      def initialize(format, opts)
        super(:alternativas, format, opts)
      end
    end
  end
end
