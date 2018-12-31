require 'rack/auth/abstract/request'

module GrapeSimpleAuth
  class Oauth2 < Grape::Middleware::Base
    attr_reader :auth_strategy

    def context
      env['api.endpoint']
    end

    def the_request=(env)
      @_the_request = ActionDispatch::Request.new(env)
    end

    def request
      @_the_request
    end

    def token
      token = if request.headers["Authorization"].present?
        if request.headers["Authorization"].include?("bearer")
          request.headers["Authorization"].try("split", "bearer").try(:last).try(:strip)
        elsif request.headers["Authorization"].include?("Bearer")
          request.headers["Authorization"].try("split", "Bearer").try(:last).try(:strip)
        else
          request.headers["Authorization"]
        end
      else
        request.parameters["access_token"]
      end
    end
    

    ############
    # Authorization control.
    ############

    def endpoint_protected?
      auth_strategy.endpoint_protected?
    end

    def auth_scopes
      return *nil unless auth_strategy.has_auth_scopes?
      auth_strategy.auth_scopes
    end

    def authorize!(*scopes)
      response = HTTParty.get(GrapeSimpleAuth.verify_url, {query: {access_token: token}})
      if response.code == 200
        scopes = response.parsed_response["data"]["credential"]["scopes"]
        unless auth_strategy.auth_scopes & scopes == auth_strategy.auth_scopes
          raise GrapeSimpleAuth::Errors::InvalidScope
        end
        return response
      end
      raise GrapeSimpleAuth::Errors::InvalidToken
    end
    
    ############
    # Grape middleware methods
    ############

    def before
      set_auth_strategy(GrapeSimpleAuth.auth_strategy)
      auth_strategy.api_context = context
      context.extend(GrapeSimpleAuth::AuthMethods)

      context.protected_endpoint = endpoint_protected?
      return unless context.protected_endpoint?

      self.the_request = env
      resp = authorize!(*auth_scopes)
      context.the_access_token = token
      context.current_user = resp.parsed_response["data"]["info"] rescue nil
      context.credentials = resp.parsed_response["data"]["credential"] rescue nil
    end


    private

    def set_auth_strategy(strategy)
      @auth_strategy = GrapeSimpleAuth::AuthStrategies.const_get(strategy.to_s.capitalize.to_s).new
    end
    
    
  end
end
