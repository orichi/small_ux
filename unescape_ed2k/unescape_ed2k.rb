#!/usr/bin/env ruby
require 'cgi'
require 'csv'

total_hash = {}
if ARGV.size > 0 && ARGV[0] && (filename = ARGV[0]; filename.match /\.txt/)
	File.open(ARGV[0], 'r') do |f|
		ruby =  f.readlines
		ruby.each do |ruby_item|
			if match_data = ruby_item.match(/(?<=\|file\|)((.*?)\.(pdf|chm|azw))/)
				total_hash[CGI.unescape(match_data[0]).to_sym] = ruby_item
			end
		end
	end
end

	CSV.open(filename.sub(/txt$/,'csv'), 'w', {encoding: 'UTF-8'}) do |csv| 
		total_hash.sort.each do |k,v|
			csv << [k.to_s, v.sub(/\n$/,'')]
		end
	end
