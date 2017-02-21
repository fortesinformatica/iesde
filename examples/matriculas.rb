$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "awesome_print"
require 'iesde'

Iesde.configure do |c| 
  c.user        = ENV['IESDE_USER']
  c.password    = ENV['IESDE_PWD']
  c.ead_api_key = ENV['EAD_API_KEY']
end


# Criar matriculas
params = {
  'CursoID'     => 105689 ,
  'PoloID'      => 1,
  'Nome'        => 'Usuario Legal',
  'CPF'         => '82432858816',
  'Email'       => 'usuario@menoslegal.com',
  'RG'          => '2003000152000',
  'OrgaoRG'     => 'Pulmão',
  'UFRG'        => 'CE',
  'CEP'         => '60120-140',
  'Endereco'    => 'Rua dos Anzois Pereira',
  'Bairro'      => 'BEM LONGE',
  'Numero'      => 123,
  'Compl'       => 'Bloco Z apto 500',
  'Telefone'    => '8588889999',
  'Celular'     => '8599999999',
  'DtNascto'    => '06/01/1966',
  'EstadoCivil' => 1,
  'Sexo'        => 'M'
}

matricula = Iesde::Model::Matricula.criar params

ap matricula.inativar!

# binding.pry

# ap matricula

# # Obter matriculas
# matriculas = Iesde::Model::Matricula.buscar
# ap matriculas