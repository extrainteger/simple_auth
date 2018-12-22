module GrapeSimpleAuth
  module Errors
    class InvalidScope < StandardError
      def initialize msg = "Invalid scope"
        super
      end
    end
  end
end