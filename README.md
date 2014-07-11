# Crunchbase API
[![Gem Version](https://badge.fury.io/rb/crunchbase-api.svg)](http://badge.fury.io/rb/crunchbase-api)
[![Build Status](https://travis-ci.org/sandisk/crunchbase-api.svg?branch=master)](https://travis-ci.org/sandisk/crunchbase-api)
[![Code Climate](https://codeclimate.com/github/sandisk/crunchbase-api.png)](https://codeclimate.com/github/sandisk/crunchbase-api)

Ruby API wrapper for [Crunchbase API](https://developer.crunchbase.com/docs) version 2.

## Installation

Add this line to your application's Gemfile:

    gem 'crunchbase-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install crunchbase-api

## Usage

You will need a Crunchbase API key. You can get one by [signing up here](https://developer.crunchbase.com).

```ruby
require 'crunchbase-api'
Crunchbase.user_key = 'YOUR_API_KEY'
```

### Example
```ruby
# Print acquisitions done by Facebook
company = Crunchbase::Organization.get 'facebook'
company.acquisitions.each do |a|
  acquisition = a.fetch
  sum = acquisition.price.nil? ? 'Unknown amount' : "#{acquisition.price} #{acquisition.price_currency_code}"
  puts "#{acquisition.announced_on.to_s}: #{acquisition.name} (#{sum})"
end

# 2014-07-02: Acquisition (500000000 USD)
# 2014-06-03: Acquisition (Unknown amount)
# 2014-04-24: Acquisition (Unknown amount)
# 2014-03-25: Facebook acquired Oculus VR (2000000000 USD)
# 2014-02-19: Facebook acquired WhatsApp (19000000000 USD)
# 2014-01-13: Facebook acquired Branch (15000000 USD)
# 2014-01-08: Facebook acquired Little Eye Labs (Unknown amount)
# 2013-12-17: Facebook acquired SportStream (Unknown amount)
```

### Notes
Failed requests (such as the ones requesting non-existent entities) will throw `Crunchbase::CrunchbaseException`.
##### Ordering
`.list` methods take an `order` argument. Valid options are `Crunchbase::ORDER_CREATED_AT_DESC` (default), `Crunchbase::ORDER_CREATED_AT_ASC`, `Crunchbase::ORDER_UPDATED_AT_DESC` and `Crunchbase::ORDER_UPDATED_AT_ASC`.
##### Relation objects
`.list` methods return an array of `Relation` objects, as do the relationship getters for most individual entities. These are summary objects returned by Crunchbase API, containing `type` and `name` of the target entity, along with timestamps. You can retrieve the "full" entity by calling `.fetch` method on the relation object.

--

### Organizations

**Organization.get** – Retrieve an organization by permalink
```ruby
Crunchbase::Organization.get(permalink)
```
Properties: `name`, `permalink`, `description`, `short_description`, `homepage_url`, `founded_on`, `is_closed`, `closed_on`, `primary_role`, `total_funding_usd`, `number_of_investments`, `number_of_employees`, `stock_symbol`, `stock_exchange`, `created_at`, `updated_at`.

Relationships: `competitors`, `funding_rounds`, `founders`, `products`, `acquisitions`, `ipo`.


**Organization.list** – Retrieves a list of organizations
```ruby
Crunchbase::Organization.list(page, order)
```
--

### People

**Person.get** – Retrieve a person profile by permalink
```ruby
Crunchbase::Person.get(permalink)
```
Properties: `first_name`, `last_name`, `permalink`, `bio`, `born_on`, `died_on`, `is_deceased`, `location_uuid`, `created_at`, `updated_at`.

Relationships: `founded_companies`.


**Person.list** – Retrieve a list of people
```ruby
Crunchbase::Person.list(page, order)
```
--

### Products

**Product.get** – Retrieve product details by permalink
```ruby
Crunchbase::Product.get(permalink)
```
Properties: `name`, `permalink`, `lifecycle_stage`, `owner_id`, `launched_on`, `died_on`,  `created_at`, `updated_at`.

**Product.list** – Retrieve a list of products
```ruby
Crunchbase::Product.list(page, order)
```
--

### Funding rounds, Acquisitions and IPOs
**FundingRound.get** – Retrieve information about funding round by uuid
```ruby
Crunchbase::FundingRound.get(uuid)
```
Properties: `name`, `permalink`, `funding_type`, `money_raised`, `money_raised_currency_code`,  `announced_on`, `canonical_currency_code`, `created_at`, `updated_at`.

Relationships: `funded_organization`.

**Acquisition.get** – Retrieve information about acquisition by uuid
```ruby
Crunchbase::Acquisition.get(uuid)
```
Properties: `name`, `permalink`, `acquisition_type`, `price`, `price_currency_code`,  `announced_on`, `disposition_of_acquired`, `created_at`, `updated_at`.

Relationships: `acquirer`, `acquiree`.

**Ipo.get** – Retrieve information about IPO by uuid
```ruby
Crunchbase::Ipo.get(uuid)
```
Properties: `name`, `permalink`, `opening_share_price`, `opening_share_price_currency_code`, `stock_symbol`,  `stock_exchange_symbol`, `went_public_on`, `canonical_currency_code`, `money_raised`, `money_raised_currency_code`, `opening_valuation`, `opening_valueation_currency_code`, `created_at`, `updated_at`.

Relationships: `funded_company`.
