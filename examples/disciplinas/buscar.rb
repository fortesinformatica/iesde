$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require "awesome_print"
require 'iesde'

def simple_call
  Iesde.configure do |c|
    c.user        = ENV['IESDE_USER']
    c.password    = ENV['IESDE_PWD']
    c.ead_api_key = ENV['EAD_API_KEY']
  end

  disciplinas = Iesde::Model::Disciplina.buscar()

  ap disciplinas
end

def call_with_config_params
  disciplinas = Iesde::Model::Disciplina.buscar(config: {
    user:        ENV['IESDE_USER'],
    password:    ENV['IESDE_PWD'],
    ead_api_key: ENV['EAD_API_KEY']
  })

  ap disciplinas
end

call_with_config_params
