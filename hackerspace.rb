require 'uri'
require 'net/http'
require 'json'
require 'time'

class Hackerspace
	attr_reader		:uri

	def initialize(uri)
		raise ArgumentError, "No URI", uri unless uri.is_a?(URI)
		@uri	= uri
	end

	def status
		res = Net::HTTP.get_response(@uri)
		return 'unknown' unless res.code == "200"
		data = JSON.parse(res.body)
		return (data["open"] ? 'open' : 'closed') << ' since ' << Time.at(data["lastchange"]).to_s
	end

end
