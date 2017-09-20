module Iesde
  module Model
    class Questao
      include Stringable

      attr_accessor :questao_id, :formato_questao_id, :formato_questao, :disciplina_id, :enunciado, :peso, :qtd_questoes, :anulada, :situacao

      def initialize(*args)        
      end

      def self.buscar(opts = {})
        questoes = Iesde::Api::ObterBancoQuestoes.new(:json, opts)
        questoes.underscorize_fields(Questao)
      end
    end
  end
end

# {\"QuestaoID\":\"5110\",
# \"FormatoQuestaoID\":\"1\",
# \"FormatoQuestao\":\"Objetiva\",
# \"DisciplinaID\":\"678\",
# \"Enunciado\":\"Com rela\\u00e7\\u00e3o \\u00e0 miss\\u00e3o e aos objetivos das escolas de governo, percebe-se\\r\\n\\r\\n\",
# \"Peso\":\"1\",
# \"QtdQuestoes\":\"4\",
# \"Anulada\":\"N\",
# \"Situacao\":\"A\"}
