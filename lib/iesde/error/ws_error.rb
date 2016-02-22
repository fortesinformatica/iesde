module Iesde
  module Error
    class WSError < ::RuntimeError
      def code
        message[1..3]
      end
    end
  end  
end