module Crunchbase

  class Acquisition < Entity

    RESOURCE_FIND = 'acquisition'

    attr_reader :name
    attr_reader :permalink
    attr_reader :acquisition_type
    attr_reader :price
    attr_reader :price_currency_code
    attr_reader :announced_on
    attr_reader :disposition_of_acquired
    attr_reader :created_at
    attr_reader :updated_at

    attr_reader :acquirer
    attr_reader :acquiree

    def self.get(uuid)
      self.fetch_one uuid
    end

    private

    def property_keys
      %w[
        name permalink acquisition_type price price_currency_code announced_on disposition_of_acquired created_at updated_at
      ]
    end

    def date_keys
      %w[announced_on]
    end

    def relationships
      %w[acquirer acquiree]
    end

  end

end