module Iesde
  class WSDLClient

    SAVON_WEB_SERVICE_ENCODING = "iso-8859-1"

    attr_accessor :action, :client, :format, :model, :wsdl_url

    def self.create client_name
      client_name.to_s.prepend("iesde/clients/").classify.constantize.new
    end

    def fetch_user_credentials params
      { login: Iesde.config.default_username, senha: Iesde.config.default_password }.merge(params)
    end

    def check_params params
      # Clients must override
      # return true if valid
      ""
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
      errors = check_params params
      raise Iesde::Error::ValidationError.new(errors) unless errors.blank?
      
      ws_response = client.call @action.underscore.to_sym, message: params, attributes: { name: "#{@action}Request"}
      raw_response = ws_response.body[@action.underscore.concat("_response").to_sym][response_param]
      map raw_response
    end

    private

    def client
      @client ||= Savon.client encoding: SAVON_WEB_SERVICE_ENCODING, wsdl: build_wsdl_url
    end

    def build_wsdl_url
      @wsdl_url || "http://ws.videoaulasonline.com.br/acoes_webservice/#{@action}/wsdl"
    end
  end
end
