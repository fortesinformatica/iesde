module Iesde
  class API
    include ActionView::Helpers::SanitizeHelper

    def initialize(o_que, format, opts = {})
      tipo   = tipo_requisicao(o_que)
      config(opts)

      request   = Request.new(tipo, format)
      @response = request.execute(opts)
    end

    def as_json
      return JSON.parse(@response)
    rescue JSON::ParserError
      return @response
    end

    def status
      as_json["status"]
    end

    def tem_chave?(chave)
      as_json.has_key?(chave)
    end

    def tem_matricula?
      tem_chave?("MatriculaID")
    end

    def salvo_com_sucesso?
      status == 1 && tem_matricula?
    end

    # Quando ocorre um erro, status = false, vem mensagem
    def msg
      msg = (status() == false) ? as_json['mensagem'] : as_json['msg']
      sanitize(msg)
    end

    def self.build_url(ask_for, format)
      [ BASE, WEB_SERVICE, ask_for, 'format', FORMATS[format]].join('/')
    end

    #TODO: colocar em cada filho
    def tipo_requisicao(o_que)
      strings = {
        cursos:             'getCursos',
        matriculas:         'getMatriculas',
        grades:             'getGrades',
        questoes:           'getBancoQuestoes',
        alternativas:       'getAlternativas',
        disciplinas:        'getDisciplinas',
        processos:          'getProcSeletivos',
        notas:              'notas',
        acessos:            'getAcessos',
        professores:        'getProfessor',
        cadastro_matricula: 'cadastro',
        info_pessoa:        'getInfoPessoa',
        alterar_matricula:  'situacao',
        aulas:              'getAulas',
        video_aula:         'getVideoAula',
        pdf:                'getPdfsDisciplina',
        get_pdf:            'getPdf'
      }

      strings[o_que]
    end

    FORMATS     = {  json: "json", html: 'html', xml: 'xml' }
    BASE        = 'http://ead.portalava.com.br'
    WEB_SERVICE = 'web_service'

  private

    def config(opts = {})
      return unless opts.has_key? :config

      config = opts[:config]

      Iesde.configure do |c|
        c.user        = config[:user]
        c.password    = config[:password]
        c.ead_api_key = config[:ead_api_key]
      end
    end
  end
end
