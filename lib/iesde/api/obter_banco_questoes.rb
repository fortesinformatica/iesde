module Iesde
  module Api
    class ObterBancoQuestoes < ::Iesde::API
      include Underscorable

      def initialize(format, opts)
        super(:questoes, format, opts)
      end
    end
  end
end
