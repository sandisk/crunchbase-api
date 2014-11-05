module Crunchbase

  class Organization < Entity

    RESOURCE_FIND = 'organization'
    RESOURCE_LIST = 'organizations'

    attr_reader :name
    attr_reader :permalink
    attr_reader :description
    attr_reader :short_description
    attr_reader :homepage_url
    attr_reader :founded_on
    attr_reader :is_closed
    attr_reader :closed_on
    attr_reader :primary_role
    attr_reader :total_funding_usd
    attr_reader :number_of_investments
    attr_reader :number_of_employees
    attr_reader :stock_symbol
    attr_reader :stock_exchange
    attr_reader :created_at
    attr_reader :updated_at

    attr_reader :competitors
    attr_reader :funding_rounds
    attr_reader :founders
    attr_reader :products
    attr_reader :acquisitions
    attr_reader :ipo

    def self.get(permalink)
      self.fetch_one permalink
    end

    def self.list(page = 1, order = ORDER_CREATED_AT_DESC)
      self.fetch_list page, order
    end

    def self.domain_name(q, page = 1)
      self.fetch_list(page, ORDER_CREATED_AT_DESC, { domain_name:q })
    end

    def self.query(q, page = 1)
      self.fetch_list(page, ORDER_CREATED_AT_DESC, { query:q })
    end

    def self.name(q, page = 1)
      self.fetch_list(page, ORDER_CREATED_AT_DESC, { name:q })
    end

    private

    def property_keys
      %w[
        description short_description founded_on permalink primary_role is_closed closed_on homepage_url
        name created_at updated_at total_funding_usd number_of_investments number_of_employees stock_symbol stock_exchange
      ]
    end

    def date_keys
      %w[founded_on closed_on]
    end

    def relationships
      %w[
        competitors funding_rounds founders products acquisitions ipo
      ]
    end

  end

end