module Crunchbase

  class Person < Entity

    RESOURCE_FIND = 'person'
    RESOURCE_LIST = 'people'

    attr_reader :first_name
    attr_reader :last_name
    attr_reader :permalink
    attr_reader :bio
    attr_reader :born_on
    attr_reader :died_on
    attr_reader :is_deceased
    attr_reader :location_uuid
    attr_reader :created_at
    attr_reader :updated_at

    attr_reader :founded_companies

    def self.get(permalink)
      self.fetch_one permalink
    end

    def self.list(page = 1, order = ORDER_CREATED_AT_DESC)
      self.fetch_list page, order
    end

    private

    def property_keys
      %w[
        first_name last_name permalink bio born_on died_on is_deceased location_uuid created_at updated_at
      ]
    end

    def date_keys
      %w[born_on died_on]
    end

    def relationships
      %w[founded_companies]
    end

  end

end