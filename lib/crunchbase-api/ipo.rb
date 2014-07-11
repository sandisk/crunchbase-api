module Crunchbase

  class Ipo < Entity

    RESOURCE_FIND = 'ipo'

    attr_reader :name
    attr_reader :permalink
    attr_reader :opening_share_price
    attr_reader :opening_share_price_currency_code
    attr_reader :stock_symbol
    attr_reader :stock_exchange_symbol
    attr_reader :went_public_on
    attr_reader :canonical_currency_code
    attr_reader :money_raised
    attr_reader :money_raised_currency_code
    attr_reader :opening_valuation
    attr_reader :opening_valuation_currency_code
    attr_reader :created_at
    attr_reader :updated_at

    attr_reader :funded_company

    def self.get(uuid)
      self.fetch_one uuid
    end

    private

    def property_keys
      %w[
        name permalink opening_share_price opening_share_price_currency_code stock_symbol stock_exchange_symbol went_public_on
        canonical_currency_code money_raised money_raised_currency_code opening_valuation opening_valuation_currency_code
        created_at updated_at
      ]
    end

    def date_keys
      %w[went_public_on]
    end

    def relationships
      %w[funded_company]
    end

  end

end