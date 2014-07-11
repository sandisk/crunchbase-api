module Crunchbase
  module Configuration

    OPTIONS = [:user_key, :api_endpoint].freeze
    USER_KEY = nil
    API_ENDPOINT = 'http://api.crunchbase.com/v/2'

    attr_accessor *OPTIONS

    def configure
      yield self
    end

    def self.extended(base)
      base.reset
    end

    def reset
      self.user_key, self.api_endpoint = USER_KEY, API_ENDPOINT
    end

  end
end