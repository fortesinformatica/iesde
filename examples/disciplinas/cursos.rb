$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require "awesome_print"
require 'iesde'

# chamada passando parametros de configuracoes
def call_with_config_params
  disciplina = Iesde::Model::Curso.buscar(
  config: {
    user:        ENV['IESDE_USER'],
    password:    ENV['IESDE_PWD'],
    ead_api_key: ENV['EAD_API_KEY']
  })

  ap disciplina.aulas(12345)
end

def simple_call
  Iesde.configure do |c|
    c.user        = ENV['IESDE_USER']
    c.password    = ENV['IESDE_PWD']
    c.ead_api_key = ENV['EAD_API_KEY']
  end

  binding.pry
  disciplina = Iesde::Model::Curso.buscar

  ap disciplina.aulas(12345)
end

# call_with_config_params
simple_call
