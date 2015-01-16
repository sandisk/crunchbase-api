require 'helper'

describe 'Product', :vcr do

  it 'should retrieve product by permalink' do
    c = Crunchbase::Product.get 'digg'
    c.description.wont_be_empty
    c.name.must_equal 'Digg'
    c.permalink.must_equal 'digg'
    c.created_at.must_be_instance_of Time
    c.updated_at.must_be_instance_of Time
  end

  it 'should retrieve a list of products' do
    c = Crunchbase::Product.list
    c.size.must_equal 1000
    c.first.must_be_instance_of Crunchbase::Relation
    c.first.type.must_equal 'Product'
    c.first.name.wont_be_empty
    c.first.path.wont_be_empty
    c.first.created_at.must_be_instance_of Time
    c.first.updated_at.must_be_instance_of Time
  end

  it 'should fetch persons returned by the list' do
    relation = Crunchbase::Relation.new({
      'type' => 'Product',
      'name' => 'Digg',
      'path' => 'product/digg',
      'created_at' => 1398758998,
      'updated_at' => 1398758998
    })
    c = relation.fetch
    c.must_be_instance_of Crunchbase::Product
    c.name.must_equal 'Digg'
  end

end