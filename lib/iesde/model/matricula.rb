module Iesde
  module Model
    class Matricula
      attr_accessor :matricula_id, :login_id, :situacao, :dt_cadastro, :curso_id, :polo_id, :curso, :aluno, :cpf, :email, :situacao_descricao, :sexo

      def initialize(*args)
        @matricula_id, @login_id, @situacao, @dt_cadastro, @curso_id, @polo_id, @curso, @aluno, @cpf, @email, @situacao_descricao, @sexo = args
      end

      def self.buscar
        matriculas_obtidas = Iesde::Api::ObterMatricula.new(:json)
        
        matriculinhas = []
        matriculas_obtidas.as_json.map do |matricula|
          params = {}

          matricula.map { |k,v| params[k.underscore.to_sym] = v }
          
          matriculinhas << Matricula.new(*params.values)
        end

        matriculinhas
      end

      def self.criar params
        nova_matricula = Iesde::Api::CriarMatricula.new(:json, params).as_json
        status = nova_matricula["status"]
        if status == 1 && nova_matricula.has_key?("MatriculaID")
          Iesde::Model::Matricula.buscar.select do |matriculinha| 
            matriculinha.matricula_id.to_s == nova_matricula["MatriculaID"].to_s
          end.first
        else
          raise Iesde::Error::WSError.new(nova_matricula["msg"])
        end
      end

      def self.alterar_status params
        api = Iesde::Api::AlterarStatusMatricula.new(:json, params)
        retorno = api.as_json
        status = retorno["status"]
        if status == 1 && retorno.has_key?("MatriculaID")
          api.sanitize_campo('msg')
        else
          raise Iesde::Error::WSError.new(retorno["msg"])
        end
      end

      def ativar!
        Iesde::Model::Matricula.alterar_status({
          'MatriculaID' => self.matricula_id,
          'Situacao'    => 'A'
        })
      end

      def inativar!
        Iesde::Model::Matricula.alterar_status({
          'MatriculaID' => self.matricula_id,
          'Situacao'    => 'I'
        })
      end

    end
  end
end
