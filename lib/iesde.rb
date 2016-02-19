require "iesde/version"
require "iesde/config"
require "iesde/curso"
require "iesde/wsdl_client"
require "iesde/clients/lista_curso"
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/inflector'

module Iesde

  mattr_accessor :config

  def self.configure
    self.config ||= Iesde::Config.new
    yield(config) if block_given?
  end

end
