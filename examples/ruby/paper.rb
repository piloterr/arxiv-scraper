# arXiv Paper API – Ruby example (stdlib only)
# Usage: PILOTERR_API_KEY=your-key ruby paper.rb
require "json"
require "net/http"
require "uri"

uri = URI("https://api.piloterr.com/v2/arxiv/paper")
uri.query = URI.encode_www_form('query' => '2201.00978 or https://arxiv.org/abs/cond-mat/0011267v1.')

request = Net::HTTP::Get.new(uri)
request["x-api-key"] = ENV.fetch("PILOTERR_API_KEY")

response = Net::HTTP.start(uri.host, uri.port, use_ssl: true, read_timeout: 60) do |http|
  http.request(request)
end

abort "Piloterr error #{response.code}: #{response.body}" unless response.is_a?(Net::HTTPSuccess)

puts JSON.pretty_generate(JSON.parse(response.body))
