#! /usr/bin/env ruby

require_relative 'beamer'
require_relative 'hackerspace'

@BEAMER_URL = 'http://beamer.nobreakspace.org'
@STATUS_URL = 'http://status.nobreakspace.org/spaceapi.json'

def parse_args(args)
	case args[0].downcase
	when /(-){0,2}help/
		help
	when 'status'
		space = Hackerspace.new(URI(@STATUS_URL))
		puts space.status
	when 'beamer'
		beamer = Beamer.new(URI(@BEAMER_URL))
		case args[1].downcase
		when 'on'
			beamer.on
		when 'off'
			beamer.off
		when 'status'
			puts(beamer.status ? 'on' : 'off' )
		when 'vga'
			beamer.output('vga')
		when 'svid'
			beamer.output('svid')
		else
			help
		end
	else
		help
	end
end

def help
	puts 'Usage: rnbsp [command] [option]'
	puts ''
	puts 'accepted commands:'
	puts '  help'
	puts '    this help'
	puts '  status'
	puts '    door status from hackerspaceapi'
	puts '  beamer'
	puts '    control beamer, accepted options:'
	puts '    on, off'
	puts '    or  vga, svid'
end

parse_args(ARGV)
