$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'iesde'
Iesde.configure do |c|
  c.user        = ENV['IESDE_USER']
  c.password    = ENV['IESDE_PWD']
  c.ead_api_key = ENV['EAD_API_KEY']
end


require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
end



require 'simplecov'

SimpleCov.start do
  add_filter "/spec/"
end

SimpleCov.start
