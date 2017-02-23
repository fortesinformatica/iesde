module Iesde
  module Api
    class ObterLinkPdf < ::Iesde::API
      include Linkable
      def initialize(format, opts)
        super(:get_pdf, format, opts)
      end
    end
  end
end
