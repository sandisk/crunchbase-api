require 'helper'

describe 'Acquisition', :vcr do

  it 'should retrieve acquisition by uuid' do
    c = Crunchbase::Acquisition.get '860a1cf3033ea1c3d16df80053360021'
    c.permalink.must_equal '860a1cf3033ea1c3d16df80053360021'
    c.acquisition_type.must_equal 'Acquisition'
    c.announced_on.must_equal Date.new(2014, 7, 2)
    c.price.must_equal 500000000
    c.price_currency_code.must_equal 'USD'
    c.name.wont_be_empty
    c.disposition_of_acquired.must_equal 'Combined'
    c.created_at.must_be_instance_of Time
    c.updated_at.must_be_instance_of Time
  end

  it 'should return relationships' do
    c = Crunchbase::Acquisition.get '860a1cf3033ea1c3d16df80053360021'

    c.acquirer.first.must_be_instance_of Crunchbase::Relation
    c.acquirer.first.type.must_equal 'Organization'
    c.acquirer.first.name.wont_be_empty
    c.acquirer.first.path.wont_be_empty

    c.acquiree.first.must_be_instance_of Crunchbase::Relation
    c.acquiree.first.type.must_equal 'Organization'
    c.acquiree.first.name.wont_be_empty
    c.acquiree.first.path.wont_be_empty
  end

end