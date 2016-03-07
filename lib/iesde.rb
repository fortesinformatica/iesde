require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/inflector'
require 'json'
require 'savon'

module Iesde
  module Clients
    autoload :ListaCurso,"iesde/clients/lista_curso"
    autoload :ObtemAula,"iesde/clients/obtem_aulas"
    autoload :ObtemMatricula,"iesde/clients/obtem_matriculas"
    autoload :Cadastro,"iesde/clients/cadastro"
    autoload :InativaAcesso,"iesde/clients/inativa_acesso"
    autoload :Logout,"iesde/clients/logout"
    autoload :Buscararquivo,"iesde/clients/buscararquivo"
  end

  module Error
    autoload :ValidationError,'iesde/error/validation_error'
    autoload :WSError,'iesde/error/ws_error'
  end

  module Model
    autoload :Curso,"iesde/model/curso"
    autoload :Aula,"iesde/model/aula"
    autoload :Matricula,"iesde/model/matricula"
    autoload :Aluno,"iesde/model/aluno"
  end

  autoload :VERSION, "iesde/version"
  autoload :Config,"iesde/config"
  autoload :WSDLClient,"iesde/wsdl_client"

  mattr_accessor :config

  def self.configure
    self.config ||= Iesde::Config.new
    yield(config) if block_given?
  end

end
