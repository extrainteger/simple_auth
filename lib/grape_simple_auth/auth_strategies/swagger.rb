module GrapeSimpleAuth
  module AuthStrategies
    class Swagger < GrapeSimpleAuth::BaseStrategy

      def optional_endpoint?
        has_authorizations? && !!optional_oauth2
      end

      def endpoint_protected?
        has_authorizations? && !!authorization_type_oauth2
      end

      def has_auth_scopes?
        endpoint_protected? && !authorization_type_oauth2.empty?
      end

      def auth_scopes
        if optional_endpoint?
          optional_oauth2.map { |hash| hash[:scope].to_sym }
        else
          authorization_type_oauth2.map { |hash| hash[:scope].to_sym }
        end
      end

      private

      def has_authorizations?
        !!endpoint_authorizations
      end

      def endpoint_authorizations
         api_context.options[:route_options][:authorizations]
      end

      def authorization_type_oauth2
        endpoint_authorizations[:oauth2]
      end

      def optional_oauth2
        endpoint_authorizations[:optional_oauth2]
      end

    end
  end
end