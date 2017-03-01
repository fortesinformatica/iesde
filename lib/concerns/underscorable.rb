module Underscorable
  def underscorize_fields model
    as_json.map do |reco|
      params = {}

      reco.map do |key, value|
        params[key.underscore.to_sym] = value
      end

      model.new(*params.values)
    end
  end
end
