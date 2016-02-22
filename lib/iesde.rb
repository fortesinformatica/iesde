require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/inflector'
require 'json'
require 'savon'

module Iesde
  module Clients
    autoload :ListaCurso,"iesde/clients/lista_curso"
    autoload :ObtemAula,"iesde/clients/obtem_aulas"
  end

  module Error
    autoload :ValidationError,'iesde/error/validation_error'
    autoload :WSError,'iesde/error/ws_error'
  end

  autoload :VERSION, "iesde/version"
  autoload :Config,"iesde/config"
  autoload :Curso,"iesde/curso"
  autoload :Aula,"iesde/aula"
  autoload :WSDLClient,"iesde/wsdl_client"

  mattr_accessor :config

  def self.configure
    self.config ||= Iesde::Config.new
    yield(config) if block_given?
  end

end
