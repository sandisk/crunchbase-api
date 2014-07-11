module Crunchbase

  class Relation

    attr_reader :type
    attr_reader :name
    attr_reader :path
    attr_reader :created_at
    attr_reader :updated_at

    def initialize(data)
      @type = data['type']
      @name = data['name']
      @path = data['path']
      @created_at = Time.at(data['created_at'])
      @updated_at = Time.at(data['updated_at'])
    end

    def fetch
      supported_relations = %w[Organization Person Product FundingRound Acquisition Ipo]
      unless supported_relations.include?(@type)
        raise CrunchbaseException, "Fetching of '#{@type}' relations is not supported at this time"
      end
      result = Crunchbase.fetch @path
      Crunchbase.const_get(@type).new result
    end

  end

end