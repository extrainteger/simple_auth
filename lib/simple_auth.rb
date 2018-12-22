require "simple_auth/version"

require 'httparty'
require 'grape'

require 'simple_auth/configuration'

require 'simple_auth/oauth2'
require 'simple_auth/extension'
require 'simple_auth/helpers'

require 'simple_auth/base_strategy'
require 'simple_auth/auth_strategies/swagger'
require 'simple_auth/auth_methods/auth_methods'

require 'simple_auth/errors/invalid_token'
require 'simple_auth/errors/invalid_scope'

module SimpleAuth
  extend SimpleAuth::Configuration

  define_setting :url, "http://localhost:4000"
  define_setting :verify_endpoint, "/v1/valid_token/verify"
  define_setting :auth_strategy, "swagger"

  def self.verify_url
    url + verify_endpoint
  end

end
