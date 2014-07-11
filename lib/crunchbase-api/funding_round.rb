module Crunchbase

  class FundingRound < Entity

    RESOURCE_FIND = 'funding-round'

    attr_reader :name
    attr_reader :permalink
    attr_reader :funding_type
    attr_reader :money_raised
    attr_reader :money_raised_currency_code
    attr_reader :announced_on
    attr_reader :canonical_currency_code
    attr_reader :created_at
    attr_reader :updated_at

    attr_reader :funded_organization

    def self.get(uuid)
      self.fetch_one uuid
    end

    private

    def property_keys
      %w[
        name permalink funding_type money_raised money_raised_currency_code
        announced_on canonical_currency_code created_at updated_at
      ]
    end

    def date_keys
      %w[announced_on]
    end

    def relationships
      %w[funded_organization]
    end

  end

end