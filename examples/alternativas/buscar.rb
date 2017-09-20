$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require "awesome_print"
require 'iesde'

# IDS = [ Expected_ids]

def simple_call
  Iesde.configure do |c|
    c.user        = ENV['IESDE_USER']
    c.password    = ENV['IESDE_PWD']
    c.ead_api_key = ENV['EAD_API_KEY']
  end

  alternativas = Iesde::Model::Alternativa.buscar({ 'disciplinaID' => 678 })

  puts alternativas.size
end

simple_call