require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.default_cassette_options = { 
    match_requests_on: [:method, 
      VCR.request_matchers.uri_without_param(:ts, :hash, :apikey)],
    }
  c.allow_http_connections_when_no_cassette = true
end