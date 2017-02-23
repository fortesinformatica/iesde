$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require "awesome_print"
require 'iesde'

Iesde.configure do |c|
  c.user        = ENV['IESDE_USER']
  c.password    = ENV['IESDE_PWD']
  c.ead_api_key = ENV['EAD_API_KEY']
end

disciplina = Iesde::Model::Disciplina.buscar.select {|d| d.disciplina_id.to_i == 203  }.first

ap disciplina.aulas(57238)