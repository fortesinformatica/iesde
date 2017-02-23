module Linkable
  def link
    return unless @response
    @response.gsub(/"/, '').gsub(/\\/, '')
  end
end
