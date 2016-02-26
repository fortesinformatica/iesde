# Iesde

Interface para acesso ao WebService do [Iesde][siteiesde] para sistemas Rails. Não se trata de uma ferramenta oficial pois foi desenvolvida por necessidade dos nossos desenvolvedores. Sintam-se livres para contribuir.

## Índice
\- [Iesde](#iesde)
  - [Versão](#vers%C3%A3o)
  - [Instalação](#instala%C3%A7%C3%A3o)
  - [Uso](#uso)
    - [Listagem de Cursos](#listagem-de-cursos)
    - [Busca de curso por Id](#busca-de-curso-por-id)
    - [Listagem de Aulas](#listagem-de-aulas)
    - [Listagem de Matrículas](#listagem-de-matr%C3%ADculas)
    - [Matricular Aluno](#matricular-aluno)
    - [Inativação de Aluno](#inativa%C3%A7%C3%A3o-de-aluno)
    - [Logout](#logout)
  - [Default Configs](#default-configs)
  - [Relacionamentos](#relacionamentos)

## Versão
1.0.0 - Seguindo a documentação v14 do WebService

## Instalação

```sh
gem install iesde -v 1.0.0
```

Ou no seu Gemfile
```ruby
gem 'iesde', '~> 1.0.0'
```

## Uso

> Todas as buscas no WebService exigem os parâmetros **login** e **senha**.
> Caso você possua apenas um usuário de acesso ao WebService, você pode configurar esses parâmetros em um initializer. 
> Veja na seção [Default Configs](#default-configs).

### Listagem de Cursos

Retorna um array de ```Iesde::Model::Curso```
```ruby
parametros = {
    login:  "0123456789", 
    senha: "9d7d5741ab23397aa15937fcd4121a32", 
    busca: "", 
    tipo: "C", 
    site: "", 
    idCurso: ""
}
cursos = Iesde::Model::Curso.buscar(parametros)
=> [#<Iesde::Model::Curso>, #<Iesde::Model::Curso>, #<Iesde::Model::Curso>, ...]
```
### Busca de curso por Id
Esta busca realiza uma varredura em todos os cursos e pacotes em busca do **id** passado como parâmetro.

Retorna um ```Iesde::Model::Curso```
```ruby
curso = Iesde::Model::Curso.find id: 1000, login: "0123456789", senha: "9d7d5741ab23397aa15937fcd4121a32"
=> #<Iesde::Model::Curso>

curso.id
=> "1000"

curso.nome
=> "A BUSCA DA PERFEICÃO"
```

### Listagem de Aulas
Retorna um array de ```Iesde::Model::Aula```

```ruby
parametros = {
    login: "0123456789", 
    senha: "9d7d5741ab23397aa15937fcd4121a32", 
    loginAluno: "", 
    cpf: "", 
    curso: "1000", 
    ancora: "", 
    tipo: "C"
}
aulas = Iesde::Model::Aula.buscar(parametros)
=> [#<Iesde::Model::Aula>, #<Iesde::Model::Aula>, #<Iesde::Model::Aula>, ...]
```

Ou já tendo o curso carregado...

```ruby
curso.aulas
=> [#<Iesde::Model::Aula>, #<Iesde::Model::Aula>, #<Iesde::Model::Aula>, ...] 
```

### Listagem de Matrículas

Retorna um array de ```Iesde::Model::Matricula ```

```ruby
parametros = {
    login: "0123456789", 
    senha: "9d7d5741ab23397aa15937fcd4121a32", 
    curso: "6376", 
    tipo: "C"
}
Iesde::Model::Matricula.buscar(parametros)
=> [#<Iesde::Model::Matricula>, #<Iesde::Model::Matricula>, #<Iesde::Model::Matricula>, ...]
```
Ou já tendo o curso carregado...

```ruby
curso.matriculas
=> [#<Iesde::Model::Matricula>, #<Iesde::Model::Matricula>, #<Iesde::Model::Matricula>, ...]
```

### Matricular Aluno

Realiza a matrícula no WebService e retorna um ```Iesde::Model::Matricula```

```ruby
parametros = {
    login: "0190001388", 
    senha: "9d7d5741ab23397afeb81829a3d5ebd7", 
    loginAluno: "aluno@minhaorganizacao.com.br", 
    cpf: "12345678900", 
    curso: "1000", 
    duracao: "90", 
    tipo: "C", 
    valor: ""
}
matricula = Iesde::Model::Matricula.criar(parametros)
=> #<Iesde::Model::Matricula>
```

### Inativação de Aluno

Inativa a matrícula e retorna ```true``` se sucesso.

```ruby
parametros = {
    login: "0190001388", 
    senha: "9d7d5741ab23397afeb81829a3d5ebd7", 
    :"LoginID" => "12345"
}
Iesde::Model::Matricula.inativar(parametros)
=> true
```

Ou caso já possua a matrícula carregada...

```ruby
matricula.inativar
=> true
```
### Logout

Realiza logout do aluno e retorna ```true``` se sucesso.

```ruby
parametros = {
    login: "0190001388", 
    senha: "9d7d5741ab23397afeb81829a3d5ebd7", 
    loginAluno: "aluno@minhaorganizacao.com.br", 
    cpf: "12345678900"
}
Iesde::Model::Aluno.logout(parametros)
=> true
```

Ou você pode obter a instância de ```Iesde::Model::Aluno``` e chamar diretamente...

```ruby
aluno = matricula.aluno
=> #<Iesde::Model::Aluno>
aluno.logout
=> true
```

```ruby
aluno = curso.matriculas.first.aluno
=> #<Iesde::Model::Aluno>
aluno.logout
=> true
```

## Default Configs
Caso você utilize apenas um usuário do WebService em sua aplicação, seria interessante não passar os parâmetros **login** e **senha** em toda busca.

Você pode configurar num initializer esses parâmetros:

```ruby
Iesde::configure do |config|
    config.default_username = "0190001388"
    config.default_password = "9d7d5741ab23397afeb81829a3d5ebd7"
end
```

Então poderá realizar as requisições sem passar estes parâmetros. Exemplos:

```ruby
cursos = Iesde::Model::Curso.buscar busca: "", tipo: "C", site: "", idCurso: ""
=> [#<Iesde::Model::Curso>, #<Iesde::Model::Curso>, #<Iesde::Model::Curso>, ...]

curso = Iesde::Model::Curso.find id: 1000
=> #<Iesde::Model::Curso>

Iesde::Model::Matricula.inativar :"LoginID" => "12345"
=> true
```

## Relacionamentos

 - Um ```Iesde::Model::Curso``` possui várias ```Iesde::Model::Aula```e várias ```Iesde::Model::Matricula```
 - Uma ```Iesde::Model::Matricula``` possui um ```Iesde::Model::Aluno``` e um ```Iesde::Model::Curso```
 - Logo ```Iesde::Model::Curso``` possui vários ```Iesde::Model::Aluno```
```ruby
# Busca aulas no WS do curso
curso.aulas
=> [#<Iesde::Model::Aula>, #<Iesde::Model::Aula>, #<Iesde::Model::Aula>, ...]

aula.curso
=> #<Iesde::Model::Curso>

curso.matriculas
=> [#<Iesde::Model::Matricula>, #<Iesde::Model::Matricula>, #<Iesde::Model::Matricula>, ...]

matricula.curso
=> #<Iesde::Model::Curso>

matricula.aluno
=> #<Iesde::Model::Aluno>

curso.alunos
=> [#<Iesde::Model::Aluno>, #<Iesde::Model::Aluno>, #<Iesde::Model::Aluno>, ...]
```

> A maioria destas operações só busca do WS uma vez. Ao buscar as aulas de um curso, elas já vem com o curso carregado em suas instâncias, evitando outra chamada ao WS para buscar o curso ao fazer ```aula.curso```.

## Licença

MIT Licence. Copyright (c) 2016 Fortes Tecnologia. http://www.fortestecnologia.com.br

![ft](http://www.fortestecnologia.com.br/templates/fortesinfo/images/grupo-fortes.png)

[siteiesde]:<http://www.iesde.com.br>
