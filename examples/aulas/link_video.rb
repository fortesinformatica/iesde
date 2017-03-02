$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require "awesome_print"
require 'iesde'

# chamada passando parametros de configuracoes
def call_with_config_params
  aulas = Iesde::Model::Aula.buscar({
    'MatriculaID'  => 12345,
    'DisciplinaID' => 123,
    config: {
      user:         ENV['IESDE_USER'],
      password:     ENV['IESDE_PWD'],
      ead_api_key:  ENV['EAD_API_KEY']
    }
  })

  ap aulas.first.link_video
end

def simple_call
  Iesde.configure do |c|
    c.user        = ENV['IESDE_USER']
    c.password    = ENV['IESDE_PWD']
    c.ead_api_key = ENV['EAD_API_KEY']
  end

  aulas = Iesde::Model::Aula.buscar({
    'MatriculaID'  => 12345,
    'DisciplinaID' => 123
  })

  ap aulas.first.link_video
end

simple_call
call_with_config_params
