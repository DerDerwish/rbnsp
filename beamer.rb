require 'uri'
require 'net/http'
require 'optparse'

class Beamer
	attr_reader		:uri

	@@http_suffix = {
		:off		=>	'/scripts/IsapiExtPj.dll?D=%05%02%01%00%00%00',
		:on			=>	'/scripts/IsapiExtPj.dll?D=%05%02%00%00%00%00',
		:svid		=>	'/scripts/IsapiExtPj.dll?D=%07%02%03%00%00%02%01%0B',
		:vid		=>	'/scripts/IsapiExtPj.dll?D=%07%02%03%00%00%02%01%06',
		:compr	=>	'/scripts/IsapiExtPj.dll?D=%07%02%03%00%00%02%01%10',
		:dvi		=>	'/scripts/IsapiExtPj.dll?D=%07%02%03%00%00%02%01%1a',
		:comp5	=>	'/scripts/IsapiExtPj.dll?D=%07%02%03%00%00%02%01%02',
		:vga		=>	'/scripts/IsapiExtPj.dll?D=%07%02%03%00%00%02%01%01'
	}

	@@http_status_prefix = '/scripts/IsapiExtPj.dll?S='

	#@@output_options = [ svid, vid, compr, dvi, comp5, vga ]

	def initialize(uri)
		raise ArgumentError, "No URI", uri unless uri.is_a?(URI)
		@uri	= uri
	end

	def status(power_on_waiting = false)
		t = Time.now
		http_suffix = power_on_waiting ? '+E%00=%01' : ''
		
    req = Net::HTTP.get(
						@uri.host,
						@@http_status_prefix << (10000*t.hour+100*t.min+t.sec).to_s
					)

		req.include?('/images/power_on_g.png')
	end

	def on
		Net::HTTP.get(@uri.host, @@http_suffix[:on])
	end

	def off
		Net::HTTP.get(@uri.host, @@http_suffix[:off])
	end

	def output(output= 'vga')
		Net::HTTP.get(@uri.host, @@http_suffix[output.to_sym])
	end

	def list_output_options
		return @@http_suffix.keys
	end
end
