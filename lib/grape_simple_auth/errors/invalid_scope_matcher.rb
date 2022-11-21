module GrapeSimpleAuth
  module Errors
    class InvalidScopeMatcher < StandardError
      def initialize msg = "match must be one of all or any"
        super
      end
    end
  end
end