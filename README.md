# Iesde

Interface para acesso ao WebService do [IESDE](http://www.iesde.com.br) para sistemas Rails. Não se trata de uma ferramenta oficial pois foi desenvolvida por necessidade dos nossos desenvolvedores. Sintam-se livres para contribuir.

## Versão
2.0.0 - Seguindo a nova documentação WebService REST. Caso esteja usando o antigo WebService SOAP utilize a [documentação da versão 1.1.1](README-OLD-API.md)

## Instalação

```sh
gem install iesde -v 2.0.0
```

Ou no seu Gemfile
```ruby
gem 'iesde', '~> 2.0.0'
```


## Default Configs
Caso você utilize apenas um usuário do WebService em sua aplicação, seria interessante não passar as chaves de acesso em toda busca.

Você pode configurar num initializer esses parâmetros:

```ruby
# config/initializers/iesde.rb

Iesde.configure do |c|
  c.user        = "1234567890123456"
  c.password    = "1234567890123456"
  c.ead_api_key = "1234567890123456"
end
```

### Listagem de Disciplinas

Retorna um array de ```Iesde::Model::Disciplina```
```ruby
disciplinas = Iesde::Model::Disciplina.buscar
=> [#<Iesde::Model::Disciplina>, #<Iesde::Model::Disciplina>, #<Iesde::Model::Disciplina>, ...]

disciplina = disciplinas.first

disciplina.curso_id
=> "123456"

disciplina.computed
=> "ELABORAÇÃO DE ROTEIROS E PACOTES"
```

### Listagem de Matrículas

Retorna um array de ```Iesde::Model::Matricula```
```ruby
Matriculas = Iesde::Model::Matricula.buscar
=> [#<Iesde::Model::Matricula>, #<Iesde::Model::Matricula>, #<Iesde::Model::Matricula>, ...]

matricula = matriculas.first

matricula.matricula_id
=> "123456"

matricula.aluno
=> "Fulano da Silva"

matricula.situacao
=> "A"
```

### Criar uma Matrícula

Retorna a ```Iesde::Model::Matricula``` criada quando parâmetros enviados corretamente.

```ruby
params = {
  'CursoID'     => 123456 ,
  'PoloID'      => 123,
  'Nome'        => 'Aluno da Silva',
  'CPF'         => '12345678900',
  'Email'       => 'aluno@email.com',
  'RG'          => '2003000152000',
  'OrgaoRG'     => 'ABC',
  'UFRG'        => 'CE',
  'CEP'         => '60120-140',
  'Endereco'    => 'Rua dos Anzois Pereira',
  'Bairro'      => 'Bairroso',
  'Numero'      => 123,
  'Compl'       => 'Bloco Z apto 500',
  'Telefone'    => '8588889999',
  'Celular'     => '8599999999',
  'DtNascto'    => '06/01/1966',
  'EstadoCivil' => 1,
  'Sexo'        => 'M'
}

matricula = Iesde::Model::Matricula.criar(params)
=> #<Iesde::Model::Matricula>
```

Se não, uma ```Iesde::Error::WSError``` é lançada com a mensagem do erro.

```ruby
Iesde::Model::Matricula.criar(parametros)
=> CPF inválido! (Iesde::Error::WSError)

Iesde::Model::Matricula.criar(parametros2)
=> Erro: Encontramos o CPF ( 12345678900 ) para o E-MAIL ( usuario@outro.com ) (Iesde::Error::WSError)

Iesde::Model::Matricula.criar(parametros)
=> Curso é um campo obrigatório! (Iesde::Error::WSError)
```

Nem todos os parâmetros são obrigatórios. Você pode utilizar o método: 

```ruby
criar_com_campos_obrigatorios(id_curso, nome, cpf, email, cep, numero_casa)
```
que retorna matrícula

```ruby
  matricula = Iesde::Model::Matricula.criar_com_campos_obrigatorios(123456, 'Fulan Da Silva', '12345678900', 'fulan@email.com','60120-140', 123)
  => #<Iesde::Model::Matricula>
```

Você pode ativar ou desativar uma matrícula através dos métodos

```ruby
  matricula = matricula.ativar!
  => #<Iesde::Model::Matricula>

  matricula.situacao
  => "A"

  matricula = matricula.inativar!
  => #<Iesde::Model::Matricula>

  matricula.situacao
  => "I"
```

### Listagem de Aulas

Retorna um array de ```Iesde::Model::Aula``` para a matrícula cujo id é passado como parâmetro.

```ruby
# Pega uma disciplina

disciplina = Iesde::Model::Disciplina.buscar.first
=> #<Iesde::Model::Disciplina>

# Lista suas aulas

disciplina.aulas(matricula.matricula_id)
=> [#<Iesde::Model::Aula>, #<Iesde::Model::Aula>, #<Iesde::Model::Aula>, ...]
```

### Link para o PDF da Disciplina

Recebe o id da matricula e retorna o link para o download do PDF

```ruby
# Pega uma disciplina

disciplina = Iesde::Model::Disciplina.buscar.first
=> #<Iesde::Model::Disciplina>

# obtem link do pdf

disciplina.pdf(matricula.matricula_id)
=> "https:://linkparao.pdf"
```

### Link para o vídeo da aula

Retorna o link para o video da aula

```ruby
# Pega uma disciplina

disciplina = Iesde::Model::Disciplina.buscar.first
=> #<Iesde::Model::Disciplina>

# Pega uma aula
aula = disciplina.aulas.first

# obtem link do video

aula.link_video
=> "https:://linkparaovideo.mp4"
```

## Passando chaves de acesso dinamicamente

Todas as funções do sistema permitem que sejam passadas as chaves de acesso de forma dinâmica limitando-se àquela ação.

Ex:
```ruby
aulas = Iesde::Model::Aula.buscar({
    'MatriculaID'  => 12345,
    'DisciplinaID' => 123,
    config: {
      user:         ENV['IESDE_USER'],
      password:     ENV['IESDE_PWD'],
      ead_api_key:  ENV['EAD_API_KEY']
    }
  })
```

## Exemplos

Você pode ver exemplos de utilização da gem na pasta [examples](https://github.com/fortesinformatica/iesde/tree/master/examples).

## Licença

MIT Licence. Copyright (c) 2017 Elore Tecnologia. http://www.elore.com.br

![el](https://d257kcgu1mtlxa.cloudfront.net/organizacoes/logotipos/000/000/036/normal/Logo_Elore.png)
![ft](http://www.fortestecnologia.com.br/templates/fortesinfo/images/grupo-fortes.png)
