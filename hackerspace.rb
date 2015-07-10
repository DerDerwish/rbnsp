require 'uri'
require 'net/http'
require 'json'

class Hackerspace
	attr_reader		:uri

	def initialize(uri)
		raise ArgumentError, "No URI", uri unless uri.is_a?(URI)
		@uri	= uri
	end

	def status
		res = Net::HTTP.get_response(@uri)
		return 'unknown' unless res.code == "200"
		return JSON.parse(res.body)["open"] ? 'open' : 'closed'
	end

end
