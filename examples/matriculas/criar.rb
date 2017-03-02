$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)
require "awesome_print"
require 'iesde'

Iesde.configure do |c|
  c.user        = ENV['IESDE_USER']
  c.password    = ENV['IESDE_PWD']
  c.ead_api_key = ENV['EAD_API_KEY']
end

# Criar matriculas
cpf        = '82432858816'
cpf_errado = '04992817564'

params = {
  'CursoID'     => 12345 ,
  'PoloID'      => 1,
  'Nome'        => 'Usuario Legal',
  'CPF'         => cpf,
  'Email'       => 'usuario@muitolegal.com',
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

matricula = Iesde::Model::Matricula.criar(params)

ap matricula
