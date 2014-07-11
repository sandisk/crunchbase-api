require 'crunchbase-api'
require 'vcr'
require 'webmock'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest-vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
end

MinitestVcr::Spec.configure!

if ENV['CRUNCHBASE_USER_KEY']
  Crunchbase.user_key = ENV['CRUNCHBASE_USER_KEY']
else
  api_config = YAML.load_file File.join(File.dirname(__FILE__), 'user_key.yml')
  Crunchbase.user_key = api_config['user_key']
end
