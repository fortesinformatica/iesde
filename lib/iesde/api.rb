module Iesde
  class API
    include ActionView::Helpers::SanitizeHelper

    def initialize(o_que, format, opts = {})
      tipo   = tipo_requisicao(o_que)
      config_api(opts)

      params    = config_params(opts)
      request   = Request.new(tipo, format, api_hash)
      @response = request.execute(params)
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

    def msg
      msg = (status() == false) ? as_json['mensagem'] : as_json['msg']
      sanitize(msg)
    end

    def self.build_url(ask_for, format)
      [ BASE, WEB_SERVICE, ask_for, 'format', FORMATS[format]].join('/')
    end

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

      strings.fetch(o_que)
    rescue ArgumentError => e
      raise 'Você precisa passar um tipo de requisição válido'
    end

    FORMATS     = { json: "json", html: 'html', xml: 'xml' }
    BASE        = 'http://ead.portalava.com.br'
    WEB_SERVICE = 'web_service'

  private

    def config_params(opts)
      opts.reject { |k,_| k == :config }
    end

    def config_api(opts = {})
      unless opts.has_key?(:config)
        ap '===> usando config original'  if ENV['DEBUG']
        opts.merge!(config: {})
      end

      # opts.merge!(config: {}) unless opts.has_key?(:config)

      _config = opts[:config]

      @user        = _config[:user]        || Iesde.config.user
      @password    = _config[:password]    || Iesde.config.password
      @ead_api_key = _config[:ead_api_key] || Iesde.config.ead_api_key

    rescue NoMethodError => e
      raise 'Você precisa configurar usuario e password'
    end

    def api_hash
      {
        config: {
                user: @user,
            password: @password,
         ead_api_key: @ead_api_key
        }
      }
    end
  end
end
