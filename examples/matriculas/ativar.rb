$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require "awesome_print"
require 'iesde'

def simple_call
  Iesde.configure do |c|
    c.user        = ENV['IESDE_USER']
    c.password    = ENV['IESDE_PWD']
    c.ead_api_key = ENV['EAD_API_KEY']
  end

  matricula = Iesde::Model::Matricula.buscar.first
  ap matricula.ativar!

  ap matricula
end


def call_with_config_params
  matricula = Iesde::Model::Matricula.buscar(
  config:{
    user:        ENV['IESDE_USER'],
    password:    ENV['IESDE_PWD'],
    ead_api_key: ENV['EAD_API_KEY']
  }).first
  ap matricula.ativar!

  ap matricula
end


simple_call
call_with_config_params
