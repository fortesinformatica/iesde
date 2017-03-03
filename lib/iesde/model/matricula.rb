module Iesde
  module Model
    class Matricula
      include Stringable

      attr_accessor :matricula_id, :login_id, :situacao, :dt_cadastro, :curso_id, :polo_id, :curso, :aluno, :cpf, :email, :situacao_descricao, :sexo

      def initialize(*args)
        @matricula_id, @login_id, @situacao, @dt_cadastro, @curso_id, @polo_id, @curso, @aluno, @cpf, @email, @situacao_descricao, @sexo = args
      end

      def self.buscar(config = {})
        matriculas_obtidas = Iesde::Api::ObterMatricula.new(:json, config)

        matriculas_obtidas.underscorize_fields(Matricula)
      end

      def self.criar params
        matricula = Iesde::Api::CriarMatricula.new(:json, params)

        if matricula.salvo_com_sucesso?
          Iesde::Model::Matricula.buscar.select do |mat|
            mat.matricula_id.to_s == matricula.matricula_id_do_retorno.to_s
          end.first
        else
          raise Iesde::Error::WSError.new(matricula.msg)
        end
      end

      def self.criar_com_campos_obrigatorios(curso_id, nome, cpf, email, cep, numero)
        self.criar(
          'CursoID' => curso_id,
          'Nome'    => nome,
          'CPF'     => cpf,
          'Email'   => email,
          'CEP'     => cep,
          'Numero'  => numero
        )
      end

      def self.alterar_status(params)
        api = Iesde::Api::AlterarStatusMatricula.new(:json, params)

        if api.salvo_com_sucesso?
          api.msg
        else
          raise Iesde::Error::WSError.new(api.msg)
        end
      end

      def ativar!(opts = {})
        Iesde::Model::Matricula.alterar_status({
          'MatriculaID' => self.matricula_id,
          'Situacao'    => 'A'
        }.merge(opts))
      end

      def inativar!(opts = {})
        Iesde::Model::Matricula.alterar_status({
          'MatriculaID' => self.matricula_id,
          'Situacao'    => 'I'
        }.merge(opts))
      end
    end
  end
end
