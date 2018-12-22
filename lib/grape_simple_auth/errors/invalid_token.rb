module GrapeSimpleAuth
  module Errors
    class InvalidToken < StandardError
      def initialize msg = "Invalid token"
        super
      end
    end
  end
end