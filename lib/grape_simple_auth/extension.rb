module GrapeSimpleAuth
  module Extension
    
    def oauth2(*scopes, match: 'any')
      description = if respond_to?(:route_setting) # >= grape-0.10.0
        route_setting(:description) || route_setting(:description, {})
      else
        @last_description ||= {}
      end

      description[:auth] = { scopes: scopes }
      description[:authorizations] = { oauth2: scopes.map { |x| { scope: x } }, scope_match: match }
    end

    def optional_oauth2(*scopes)
      description = if respond_to?(:route_setting) # >= grape-0.10.0
        route_setting(:description) || route_setting(:description, {})
      else
        @last_description ||= {}
      end

      description[:authorizations] = { optional_oauth2: scopes.map { |x| { scope: x } } }
    end

    grape_api = defined?(Grape::API::Instance) ? Grape::API::Instance : Grape::API
    grape_api.extend self
  end
end