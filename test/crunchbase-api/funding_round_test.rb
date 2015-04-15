require 'helper'

describe 'FundingRound', :vcr do

  it 'should retrieve funding round by uuid' do
    c = Crunchbase::FundingRound.get '37bd05f961af726ba3c1b279da842805'
    c.permalink.must_equal '37bd05f961af726ba3c1b279da842805'
    c.funding_type.must_equal 'private_equity'
    c.money_raised.must_equal 1500000000
    c.money_raised_currency_code.must_equal 'USD'
    c.series = 'a'
    c.announced_on.must_equal Date.new(2011, 1, 21)
    c.canonical_currency_code.must_equal 'USD'
    c.permalink.wont_be_empty
    c.name.wont_be_empty
    c.created_at.must_be_instance_of Time
    c.updated_at.must_be_instance_of Time
  end

  it 'should return relationships' do
    c = Crunchbase::FundingRound.get '37bd05f961af726ba3c1b279da842805'

    c.funded_organization.first.must_be_instance_of Crunchbase::Relation
    c.funded_organization.first.type.must_equal 'Organization'
    c.funded_organization.first.name.wont_be_empty
    c.funded_organization.first.path.wont_be_empty
  end

end
