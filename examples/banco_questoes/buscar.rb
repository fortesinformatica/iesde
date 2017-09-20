$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require "awesome_print"
require 'iesde'

# IDS = [ Expected_ids]

def simple_call
  Iesde.configure do |c|
    c.user        = ENV['IESDE_USER']
    c.password    = ENV['IESDE_PWD']
    c.ead_api_key = ENV['EAD_API_KEY']
  end

  questoes = Iesde::Model::Questao.buscar()

  puts questoes.size
end

simple_call


# {\"QuestaoID\":\"5110\",
# \"FormatoQuestaoID\":\"1\",
# \"FormatoQuestao\":\"Objetiva\",
# \"DisciplinaID\":\"678\",
# \"Enunciado\":\"Com rela\\u00e7\\u00e3o \\u00e0 miss\\u00e3o e aos objetivos das escolas de governo, percebe-se\\r\\n\\r\\n\",
# \"Peso\":\"1\",
# \"QtdQuestoes\":\"4\",
# \"Anulada\":\"N\",
# \"Situacao\":\"A\"}

# {\"QuestaoID\":\"23461\",
# \"FormatoQuestaoID\":\"1\",
# \"FormatoQuestao\":\"Objetiva\",
# \"DisciplinaID\":\"1353\",
# \"Enunciado\":\"O que \\u00e9 a democracia na escola p\\u00fablica?\\r\\n\\r\\n\\r\\n\",
# \"Peso\":\"1\",
# \"QtdQuestoes\":\"4\",
# \"Anulada\":\"N\",
# \"Situacao\":\"A\"}

# {\"QuestaoID\":\"13247\",
# \"FormatoQuestaoID\":\"1\",
# \"FormatoQuestao\":\"Objetiva\",
# \"DisciplinaID\":\"100\",
# \"Enunciado\":\"A ___________ est\\u00e1 relacionada com as habilidades motoras. Ao se movimentar, o homem conhece melhor a si mesmo, transgride seus limites, estipula e alcan\\u00e7a objetivos e obt\\u00e9m prazer.\\r\\n\\r\\n\\r\\nA palavra que completa corretamente essa afirma\\u00e7\\u00e3o \\u00e9:\\r\\n\\r\\n\\r\\n\",
# \"Peso\":\"1\",
# \"QtdQuestoes\":\"4\",
# \"Anulada\":\"N\",
# \"Situacao\":\"A\"}

# {\"QuestaoID\":\"13433\",
# \"FormatoQuestaoID\":\"1\",
# \"FormatoQuestao\":\"Objetiva\",
# \"DisciplinaID\":\"527\",
# \"Enunciado\":\"Cumulatividade na satisfa\\u00e7\\u00e3o indica que\\r\\n\\r\\n\",
# \"Peso\":\"1\",
# \"QtdQuestoes\":\"4\",
# \"Anulada\":\"N\",
# \"Situacao\":\"A\"}

# {\"QuestaoID\":\"25297\",
# \"FormatoQuestaoID\":\"1\",
# \"FormatoQuestao\":\"Objetiva\",
# \"DisciplinaID\":\"251\",
# \"Enunciado\":\"Quando um fundo de investimentos contrata uma consultoria para averiguar os resultados de um resort nos \\u00faltimos cinco anos e, com base nesses dados, projetar os cinco anos seguintes, est\\u00e1 solicitando uma\",
# \"Peso\":\"1\",
# \"QtdQuestoes\":\"4\",
# \"Anulada\":\"N\",
# \"Situacao\":\"A\"}

# {\"QuestaoID\":\"26068\",
# \"FormatoQuestaoID\":\"1\",
# \"FormatoQuestao\":\"Objetiva\",
# \"DisciplinaID\":\"671\",
# \"Enunciado\":\"Analise as afirma\\u00e7\\u00f5es abaixo.\\r\\n\\r\\nI. A opini\\u00e3o p\\u00fablica s\\u00f3 pode ser poss\\u00edvel ap\\u00f3s o surgimento da imprensa.II. Os pensadores do Iluminismo conseguiam atingir um n\\u00famero maior de pessoas com suas ideias porque utilizavam v\\u00e1rios materiais impressos para divulga\\u00e7\\u00e3o.III. Somente a aristocracia tinha acesso aos meios impressos, tais como livros, panfletos, pois somente ssa classe era alfabetizada.\\r\\nPodemos afirmar que\",
# \"Peso\":\"1\",
# \"QtdQuestoes\":\"4\",
# \"Anulada\":\"N\",
# \"Situacao\":\"A\"}