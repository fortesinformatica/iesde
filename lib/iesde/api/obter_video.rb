module Iesde
  module Api
    class ObterVideo < ::Iesde::API
      include Linkable

      def initialize(format, opts)
        super(:video_aula, format, opts)
      end
    end
  end
end
