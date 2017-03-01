module Stringable
  def to_s
    instance_variables.map do |v|
      "#{v[1..-1]}: #{instance_variable_get(v)}"
    end.join(', ' )
  end
end
