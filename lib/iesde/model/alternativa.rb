module Iesde
  module Model
    class Alternativa
      include Stringable

      attr_accessor :alternativa_id, :texto, :correta, :questao_id

      def initialize(*args)        
      end

      def self.buscar(opts = {})
        alternativas = Iesde::Api::ObterAlternativas.new(:json, opts)
        alternativas.underscorize_fields(Alternativa)
      end
    end
  end
end

# {\"AlternativaID\":\"20421\",
# \"Texto\":\"converg\\u00eancia nas miss\\u00f5es e objetivos das escolas nacionais.<br><br>\",
# \"Correta\":\"S\",
# \"QuestaoID\":\"5110\"}
