module SimpleAuth
  module AuthMethods
    attr_accessor :the_access_token, :current_user, :credentials

    def protected_endpoint=(protected)
      @protected_endpoint = protected
    end

    def protected_endpoint?
      @protected_endpoint || false
    end

    def the_access_token
      @_the_access_token
    end

    def the_access_token=(token)
      @_the_access_token = token
    end

    def current_user=(info)
      @_current_user = JSON.parse(info.to_json, object_class: DataStruct)
    end

    def current_user
      @_current_user
    end
    
    def credentials=(data)
      @credentials = JSON.parse(data.to_json, object_class: DataStruct)
    end

    def credentials
      @credentials
    end

    class DataStruct < OpenStruct
      def as_json(*args)
        super.as_json['table']
      end
    end
    
  end
end