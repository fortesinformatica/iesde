require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/inflector'
require 'action_view'
require 'json'
require 'net/http'
require 'net/http/digest_auth'
require 'uri'
require "awesome_print"
require "pry"

module Iesde
  autoload :Request, 'iesde/request'
  autoload :API,     'iesde/api'

  module Api
    autoload :ObterMatricula,         "iesde/api/obter_matricula"
    autoload :CriarMatricula,         "iesde/api/criar_matricula"
    autoload :AlterarStatusMatricula, "iesde/api/alterar_status_matricula"
    autoload :ObterDisciplina,        "iesde/api/obter_disciplina"
    autoload :ObterAula,              "iesde/api/obter_aula"
    autoload :ObterDadosPdf,          "iesde/api/obter_dados_pdf"
    autoload :ObterLinkPdf,           "iesde/api/obter_link_pdf"
    autoload :ObterVideo,             "iesde/api/obter_video"
    autoload :ObterBancoQuestoes,     "iesde/api/obter_banco_questoes"
    autoload :ObterAlternativas,      "iesde/api/obter_alternativas"
    autoload :ObterCurso,             "iesde/api/obter_curso"
  end

  module Clients
    autoload :ListaCurso,"iesde/clients/lista_curso"
  end

  module Error
    autoload :WSError,'iesde/error/ws_error'
  end

  module Model
    autoload :Matricula,   "iesde/model/matricula"
    autoload :Disciplina,  "iesde/model/disciplina"
    autoload :Curso,       "iesde/model/curso"
    autoload :Aula,        "iesde/model/aula"
    autoload :Questao,     "iesde/model/questao"
    autoload :Alternativa, "iesde/model/alternativa"
  end

  autoload :VERSION,       "iesde/version"
  autoload :Config,        "iesde/config"
  autoload :Linkable,      "concerns/linkable"
  autoload :Underscorable, "concerns/underscorable"
  autoload :Stringable,    "concerns/stringable"

  mattr_accessor :config

  def self.configure
    self.config ||= Iesde::Config.new
    yield(config) if block_given?
  end
end
