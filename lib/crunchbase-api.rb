require 'crunchbase-api/configuration'
require 'crunchbase-api/crunchbase_exception'
require 'crunchbase-api/relation'
require 'crunchbase-api/entity'
require 'crunchbase-api/person'
require 'crunchbase-api/product'
require 'crunchbase-api/organization'
require 'crunchbase-api/acquisition'
require 'crunchbase-api/funding_round'
require 'crunchbase-api/ipo'
require 'crunchbase-api/version'

module Crunchbase
  extend Configuration

  ORDER_CREATED_AT_ASC = 'created_at asc'
  ORDER_CREATED_AT_DESC = 'created_at desc'
  ORDER_UPDATED_AT_ASC = 'updated_at asc'
  ORDER_UPDATED_AT_DESC = 'updated_at desc'

  class << self

    def fetch(resource, data = {})
      data[:user_key] = self.user_key
      uri = "#{self.api_endpoint}/#{resource}?"
      uri << data.map { |k, v| "#{CGI::escape(k.to_s)}=#{CGI::escape(v.to_s)}" }.join('&')

      begin
        response = Net::HTTP.get_response(URI.parse uri)
        raise CrunchbaseException, response.body.to_s unless response.code.to_i == 200
        body = response.body.to_s
      rescue => e
        raise CrunchbaseException, "Failed to fetch #{uri}: #{e}"
      end

      begin
        response = JSON.parse body
      rescue => e
        raise CrunchbaseException, "Failed to parse response for #{uri}: #{e}"
      end

      if response['data']['error'] and response['data']['error']['message']
        raise CrunchbaseException, response['data']['error']['message']
      end

      response['data']
    end

  end
end
