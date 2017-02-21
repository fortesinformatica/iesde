module Iesde
  class API
    include ActionView::Helpers::SanitizeHelper

    def initialize(o_que, format, opts = {})
      tipo = tipo_requisicao(o_que)

      @request = Request.new(tipo, format)
      @all     = @request.execute(opts)
    end

    def todas
      @all
    end

    def as_json
      JSON.parse(@all)
    end

    def count
      @all.size
    end

    def self.build_url(ask_for, format)
      [ BASE, WEB_SERVICE, ask_for, 'format', FORMATS[format]].join('/')
    end

    def sanitize_campo campo
      sanitize(as_json[campo])
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

    FORMATS  = {  json: "json", html: 'html', xml: 'xml' }
    BASE        = 'http://ead.portalava.com.br'
    WEB_SERVICE = 'web_service'
  end
end
