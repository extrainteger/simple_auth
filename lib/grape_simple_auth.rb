require "grape_simple_auth/version"

require 'httparty'
require 'grape'

require 'grape_simple_auth/configuration'

require 'grape_simple_auth/oauth2'
require 'grape_simple_auth/extension'
require 'grape_simple_auth/helpers'

require 'grape_simple_auth/base_strategy'
require 'grape_simple_auth/auth_strategies/swagger'
require 'grape_simple_auth/auth_methods/auth_methods'

require 'grape_simple_auth/errors/invalid_token'
require 'grape_simple_auth/errors/invalid_scope'
require 'grape_simple_auth/errors/invalid_scope_matcher'

module GrapeSimpleAuth
  extend GrapeSimpleAuth::Configuration

  define_setting :url, "http://localhost:4000"
  define_setting :verify_endpoint, "/v1/valid_token/verify"
  define_setting :auth_strategy, "swagger"
  define_setting :current_user_class, "User"

  def self.verify_url
    url + verify_endpoint
  end

end
