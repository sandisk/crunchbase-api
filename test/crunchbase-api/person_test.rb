require 'helper'

describe 'Person', :vcr do

  it 'should retrieve person by permalink' do
    c = Crunchbase::Person.get 'steve-jobs'
    c.first_name.must_equal 'Steve'
    c.last_name.must_equal 'Jobs'
    c.permalink.must_equal 'steve-jobs'
    c.bio.wont_be_empty
    c.born_on.must_equal Date.new(1955, 2, 24)
    c.died_on.must_equal Date.new(2011, 10, 5)
    c.is_deceased.must_equal true
    c.location_uuid.wont_be_empty
    c.created_at.must_be_instance_of Time
    c.updated_at.must_be_instance_of Time
  end

  it 'should retrieve a list of people' do
    c = Crunchbase::Person.list
    c.size.must_equal 1000
    c.first.must_be_instance_of Crunchbase::Relation
    c.first.type.must_equal 'Person'
    c.first.name.wont_be_empty
    c.first.path.wont_be_empty
    c.first.created_at.must_be_instance_of Time
    c.first.updated_at.must_be_instance_of Time
  end

  it 'should fetch persons returned by the list' do
    relation = Crunchbase::Relation.new({
      'type' => 'Person',
      'name' => 'Steve Jobs',
      'path' => 'person/steve-jobs',
      'created_at' => 1401124619,
      'updated_at' => 1401124619
      })
    c = relation.fetch
    c.must_be_instance_of Crunchbase::Person
    c.first_name.must_equal 'Steve'
  end

  it 'should return relationships' do
    c = Crunchbase::Person.get 'steve-jobs'

    c.founded_companies.first.must_be_instance_of Crunchbase::Relation
    c.founded_companies.first.type.must_equal 'Organization'
    c.founded_companies.first.name.wont_be_empty
    c.founded_companies.first.path.wont_be_empty
  end

end