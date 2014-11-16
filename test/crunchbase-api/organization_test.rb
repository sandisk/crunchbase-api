require 'helper'

describe 'Organization', :vcr do

  it 'should retrieve organization by domain' do
    relation = Crunchbase::Organization.find_all_by_domain_name('facebook.com').first
    c = relation.fetch
    c.must_be_instance_of Crunchbase::Organization
    c.name.must_equal 'Facebook'
  end

  it 'should retrieve organization by name' do
    relation = Crunchbase::Organization.find_all_by_name('Facebook').first
    c = relation.fetch
    c.must_be_instance_of Crunchbase::Organization
    c.name.must_equal 'Facebook'
  end

  it 'should retrieve organization by query' do
    relation = Crunchbase::Organization.find_all_by_query('Faceboo').first
    c = relation.fetch
    c.must_be_instance_of Crunchbase::Organization
    c.name.must_equal 'Facebook'
  end

  it 'should retrieve organization by permalink' do
    c = Crunchbase::Organization.get 'facebook'
    c.name.must_equal 'Facebook'
    c.permalink.must_equal 'facebook'
    c.description.wont_be_empty
    c.short_description.wont_be_empty
    c.homepage_url.must_include 'facebook.com'
    c.founded_on.must_equal Date.new(2004, 02, 04)
    c.total_funding_usd.must_be_instance_of Fixnum
    c.number_of_investments.must_be_instance_of Fixnum
    c.number_of_employees.must_be_instance_of Fixnum
    c.stock_symbol.must_equal 'FB'
    c.created_at.must_be_instance_of Time
    c.updated_at.must_be_instance_of Time
  end

  it 'should retrieve a list of organizations' do
    c = Crunchbase::Organization.list
    c.size.must_equal 1000
    c.first.must_be_instance_of Crunchbase::Relation
    c.first.type.must_equal 'Organization'
    c.first.name.wont_be_empty
    c.first.path.wont_be_empty
    c.first.created_at.must_be_instance_of Time
    c.first.updated_at.must_be_instance_of Time
  end

  it 'should fetch organizations returned by the list' do
    relation = Crunchbase::Relation.new({
      'type' => 'Organization',
      'name' => 'Facebook',
      'path' => 'organization/facebook',
      'created_at' => 1180153335,
      'updated_at' => 1404773288
    })
    c = relation.fetch
    c.must_be_instance_of Crunchbase::Organization
    c.name.must_equal 'Facebook'
  end

  it 'should return relationships' do
    c = Crunchbase::Organization.get 'apple'

    c.competitors.first.must_be_instance_of Crunchbase::Relation
    c.competitors.first.type.must_equal 'Organization'
    c.competitors.first.name.wont_be_empty
    c.competitors.first.path.wont_be_empty

    c.founders.first.must_be_instance_of Crunchbase::Relation
    c.founders.first.type.must_equal 'Person'
    c.founders.first.name.wont_be_empty
    c.founders.first.path.wont_be_empty

    c.products.first.must_be_instance_of Crunchbase::Relation
    c.products.first.type.must_equal 'Product'
    c.products.first.name.wont_be_empty
    c.products.first.path.wont_be_empty

    c.acquisitions.first.must_be_instance_of Crunchbase::Relation
    c.acquisitions.first.type.must_equal 'Acquisition'
    c.acquisitions.first.name.wont_be_empty
    c.acquisitions.first.path.wont_be_empty

    c.ipo.first.must_be_instance_of Crunchbase::Relation
    c.ipo.first.type.must_equal 'Ipo'
    c.ipo.first.name.wont_be_empty
    c.ipo.first.path.wont_be_empty
  end

end