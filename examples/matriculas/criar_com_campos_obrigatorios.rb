$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require "awesome_print"
require 'iesde'

Iesde.configure do |c|
  c.user        = ENV['IESDE_USER']
  c.password    = ENV['IESDE_PWD']
  c.ead_api_key = ENV['EAD_API_KEY']
end

matricula = Iesde::Model::Matricula.criar_com_campos_obrigatorios(
  123456,
  'Heron Da Silva',
  '83550113501',
  'heron@email2.com',
  '60120-140',
  123
)

ap matricula
