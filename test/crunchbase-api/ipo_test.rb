describe 'IPO', :vcr do

  it 'should retrieve IPO by uuid' do
    c = Crunchbase::Ipo.get '8fd30bb39eb9839d452685f82c1bfdf7'
    c.permalink.must_equal '8fd30bb39eb9839d452685f82c1bfdf7'
    c.opening_share_price.must_equal '38.0'
    c.opening_share_price_currency_code.must_equal 'USD'
    c.stock_symbol.must_equal 'FB'
    c.went_public_on.must_equal Date.new(2012, 5, 18)
    c.canonical_currency_code.must_equal 'USD'
    c.money_raised.must_equal 18400000000
    c.money_raised_currency_code.must_equal 'USD'
    c.name.wont_be_empty
    c.opening_valuation.must_equal 104000000000
    c.opening_valuation_currency_code.must_equal 'USD'
    c.created_at.must_be_instance_of Time
    c.updated_at.must_be_instance_of Time
  end

  it 'should return relationships' do
    c = Crunchbase::Ipo.get '8fd30bb39eb9839d452685f82c1bfdf7'

    c.funded_company.first.must_be_instance_of Crunchbase::Relation
    c.funded_company.first.type.must_equal 'Organization'
    c.funded_company.first.name.wont_be_empty
    c.funded_company.first.path.wont_be_empty
  end

end