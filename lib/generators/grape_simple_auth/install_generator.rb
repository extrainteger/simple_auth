module GrapeSimpleAuth
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../../templates", __FILE__)

    def copy_initializer
      template "initializer.rb", "config/initializers/grape_simple_auth.rb"
    end
  end
end