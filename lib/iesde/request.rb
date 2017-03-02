module Iesde
  class Request
    def initialize(ask_for, format, config = {})
      @uri     =  build_uri(ask_for, format)
      @format  = format
      @retorno = []
    end

    def execute(opts = {})
      res = do_the_post(opts)

      case res.code
      when '200'
        @retorno = res.body
      when '400'
        @retorno = res.body
      else
        raise "Ocorreu um erro"
      end
    end

  private

    def build_uri(ask_for, format)
      url           = Iesde::API.build_url(ask_for, format)
      _uri          = URI.parse(url)
      _uri.user     = Iesde.config.user
      _uri.password = Iesde.config.password

      _uri
    end

    def pega_autorizacao(h)
      res         = pega_autenticacao(h)
      digest_auth = Net::HTTP::DigestAuth.new
      auth        = digest_auth.auth_header @uri, res['www-authenticate'], 'POST'

      auth
    end

    def pega_autenticacao(h)
      req = Net::HTTP::Head.new(@uri.request_uri)
      res = h.request(req)

      res
    end

    def config_host
      http = Net::HTTP.new(@uri.host, @uri.port)
      http.set_debug_output $stderr if ENV['DEBUG']

      http
    end

    def do_the_post(opts = {})
      h    = config_host
      auth = pega_autorizacao(h)

      req = Net::HTTP::Post.new(@uri.request_uri)
      req.add_field 'Authorization', auth
      req.add_field 'ead-api-key', Iesde.config.ead_api_key
      req.set_form_data(opts)

      res = h.request(req)
      res
    end
  end
end
