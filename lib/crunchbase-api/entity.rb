require 'date'

module Crunchbase
  class Entity

    def initialize(data)
      property_keys.each { |v| instance_variable_set("@#{v}", data['properties'][v] || nil) }
      date_keys.each { |v| instance_variable_set("@#{v}", data['properties'][v].nil? ? nil : Date.parse(data['properties'][v])) }
      %w[created_at updated_at].each { |v| instance_variable_set("@#{v}", Time.at(data['properties'][v])) }
      relationships.each { |v| set_relationships(v, data['relationships'][v] || nil) }
    end

    private

    def self.fetch_one(permalink)
      self.new Crunchbase::fetch("#{self::RESOURCE_FIND}/#{permalink}")
    end

    def self.fetch_list(page = 1, order = ORDER_CREATED_AT_DESC, params = {})
      r = Crunchbase::fetch(self::RESOURCE_LIST, params.merge(page: page, order: order))['items']
      r.map { |i| Relation.new i }
    end

    def property_keys
      []
    end

    def date_keys
      []
    end

    def relationships
      []
    end

    def set_relationships(key, data)
      return unless data and data['items'].respond_to?(:each)
      items = []
      data['items'].each { |v| items << Relation.new(v) }
      instance_variable_set "@#{key}", items
    end

  end
end
