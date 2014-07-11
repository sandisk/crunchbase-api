module Crunchbase

  class Product < Entity

    RESOURCE_FIND = 'product'
    RESOURCE_LIST = 'products'

    attr_reader :name
    attr_reader :permalink
    attr_reader :lifecycle_stage
    attr_reader :owner_id
    attr_reader :description
    attr_reader :homepage_url
    attr_reader :launched_on
    attr_reader :created_at
    attr_reader :updated_at

    def self.get(permalink)
      self.fetch_one permalink
    end

    def self.list(page = 1, order = ORDER_CREATED_AT_DESC)
      self.fetch_list page, order
    end

    private

    def property_keys
      %w[
        lifecycle_stage owner_id description permalink homepage_url name launched_on
        created_at updated_at
      ]
    end

    def date_keys
      %w[launched_on]
    end

  end

end