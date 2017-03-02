$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require "awesome_print"
require 'iesde'

Iesde.configure do |c|
  c.user        = ENV['IESDE_USER']
  c.password    = ENV['IESDE_PWD']
  c.ead_api_key = ENV['EAD_API_KEY']
end

disciplina = Iesde::Model::Disciplina.buscar.select {|d| d.disciplina_id.to_i == 123  }.first

link_pdf = disciplina.pdf(12345)
ap link_pdf
