$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require "awesome_print"
require 'iesde'

Iesde.configure do |c|
  c.user        = ENV['IESDE_USER']
  c.password    = ENV['IESDE_PWD']
  c.ead_api_key = ENV['EAD_API_KEY']
end


disciplina = Iesde::Model::Disciplina.buscar.select {|d| d.disciplina_id.to_i == 123  }.first

# dados = disciplina.dados_pdf(12345)
# link_pdf = disciplina.link_pdf(12345, dados[0]["LivroDisciplinaID"])

# ap link_pdf

link_pdf = disciplina.pdf(12345)
ap link_pdf
