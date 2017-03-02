$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require "awesome_print"
require 'iesde'

# chamada passando parametros de configuracoes
def call_with_config_params
  disciplina = Iesde::Model::Disciplina.buscar(
  config: {
    user:        ENV['IESDE_USER'],
    password:    ENV['IESDE_PWD'],
    ead_api_key: ENV['EAD_API_KEY']
  }).select {|d| d.disciplina_id.to_i == 123  }.first

  ap disciplina.aulas(12345)
end

def simple_call
  Iesde.configure do |c|
    c.user        = ENV['IESDE_USER']
    c.password    = ENV['IESDE_PWD']
    c.ead_api_key = ENV['EAD_API_KEY']
  end

  disciplina = Iesde::Model::Disciplina.buscar.select {|d| d.disciplina_id.to_i == 123  }.first

  ap disciplina.aulas(12345)
end

call_with_config_params
simple_call
