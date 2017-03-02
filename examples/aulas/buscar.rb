$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require "awesome_print"
require 'iesde'

IDS = [ Expected_ids]

def call_with_config_params
  aulas_com_config =  Iesde::Model::Aula.buscar({
    'MatriculaID'  => 12345,
    'DisciplinaID' => 123,
    config: {
      user:        ENV['IESDE_USER'],
      password:    ENV['IESDE_PWD'],
      ead_api_key: ENV['EAD_API_KEY']
    }
  })

  puts aulas_com_config.size == IDS.length

  puts aulas_com_config.map(&:matricula_id) == IDS

  puts aulas_com_config.map(&:to_s)
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

  ap aulas.size == IDS.length

  ap aulas.map(&:matricula_id) == IDS
  puts aulas.map(&:to_s)
end

call_with_config_params

simple_call
