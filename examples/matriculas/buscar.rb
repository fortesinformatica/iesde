$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require "awesome_print"
require 'iesde'

config = {
  config: {
    user:         ENV['IESDE_USER'],
    password:     ENV['IESDE_PWD'],
    ead_api_key:  ENV['EAD_API_KEY']
  }
}

matricula = Iesde::Model::Matricula.buscar(config)
require 'pry'; binding.pry
ap matricula
