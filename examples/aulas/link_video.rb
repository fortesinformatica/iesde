$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require "awesome_print"
require 'iesde'

Iesde.configure do |c|
  c.user        = ENV['IESDE_USER']
  c.password    = ENV['IESDE_PWD']
  c.ead_api_key = ENV['EAD_API_KEY']
end

aulas = Iesde::Model::Aula.buscar({
  'MatriculaID'  => 57238,
  'DisciplinaID' => 203
})

ap aulas.first.link_video
