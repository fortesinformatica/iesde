module Iesde
  class WSDLClient

    CLIENTS_FOLDER = 'iesde/clients/'
    SAVON_WEB_SERVICE_ENCODING = "iso-8859-1"
    DEFAULT_WSDL_URL = "http://ws.videoaulasonline.com.br/acoes_webservice/:action/wsdl"
    REQUEST_SUFIX = 'Request'
    RESPONSE_PARAM_SUFIX = '_response'

    attr_accessor :action, :client, :format, :obligatory_params, :model, :wsdl_url

    def self.create client_name
      client_name.to_s.prepend(CLIENTS_FOLDER).classify.constantize.new
    end

    def fetch_user_credentials params
      { login: Iesde.config.default_username, senha: Iesde.config.default_password }.merge(params)
    end

    def check_params_format params
      errors = ""
      errors << "[Parâmetros incorretos! formato -> #{@format}]" unless params.keys.eql? @format
      errors
    end

    def check_obligatory_params params
      errors = ""
      @obligatory_params.each do |param|
        errors << "#{param} - Parâmetro Obrigatório!" if params[param].nil?
      end
      errors
    end

    def check_params params
      errors = ""
      errors << "[Login pode ter no máx 10 digitos]" if params[:login].size > 10
      errors << "[Senha pode ter no máx 32 digitos]" if params[:senha].size > 32
      errors
    end

    def validate params
      errors = check_params_format params
      errors = check_obligatory_params params if errors.empty?
      errors = check_params params if errors.empty?
      errors
    end

    def map response
      JSON.parse(response).collect do |item|
        model.new *item.values
      end
    rescue JSON::ParserError
      raise Iesde::Error::WSError.new(response)
    end

    def response_param
      :resultado
    end

    def run params
      params = fetch_user_credentials(params) if Iesde.config && params[:login].blank? && params[:senha].blank?
      errors = validate params
      raise Iesde::Error::ValidationError.new(errors) unless errors.blank?
      ws_response = client.call @action.underscore.to_sym, message: params, attributes: { name: (@action + REQUEST_SUFIX) }
      raw_response = ws_response.body[@action.underscore.concat(RESPONSE_PARAM_SUFIX).to_sym][response_param]
      map raw_response
    end

    private

    def client
      @client ||= Savon.client encoding: SAVON_WEB_SERVICE_ENCODING, wsdl: build_wsdl_url
    end

    def build_wsdl_url
      @wsdl_url || DEFAULT_WSDL_URL.gsub(/:action/, @action)
    end
  end
end
