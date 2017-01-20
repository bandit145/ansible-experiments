#!/usr/bin/env ruby
require 'sensu-plugin/check/cli'
class RAM < Sensu::Plugin::Check::CLI 

	option :warn,
	short: '-w WARN',
	proc: proc {|a| a.to_f},
	default: 0.80

	option :crit,
	short: '-c CRIT',
	proc: proc {|a| a.to_f},
	default: 0.90

	def run
		if RUBY_PLATFORM.include? 'linux'
			ramper = linux()
		elsif RUBY_PLATFORM.include? 'mingw32'
			ramper = windows()
		end
		if config[:crit]  > 1
			config[:crit]  = config[:crit] /100
		end
		if config[:warn] > 1
			config[:warn] = config[:warn] /100
		end

		critical((((ramper*100).to_i).to_s)+'%') if ramper >= config[:crit]
		warning((((ramper*100).to_i).to_s)+'%') if ramper > config[:warn]
		ok((((ramper*100).to_i).to_s)+'%')
	end

	def linux
		io = IO.popen("free -m | awk 'FNR ==2 {print $2\":\"$3}'")
		rawdata = io.read()
		rawdata = rawdata.strip()
		rawdata = rawdata.tr('G','')
	 	totalram, usedram = rawdata.split(':')
		usedram = usedram.to_f
		totalram = totalram.to_f
		ramper = usedram / totalram
		return ramper
	end

	def windows
#I hope these wmic objects stay at the decimals they are 
		io = IO.popen("wmic os get freephysicalmemory")
		freeram = io.read
		io = IO.popen("wmic computersystem get totalphysicalmemory")
		totalram = io.read
		freeram = freeram.strip()
		freeram = freeram.tr('FreePhysicalMemory','')
		freeram = freeram.strip()
		totalram = totalram.strip()
		totalram = totalram.tr('TotalPhysicalMemory','')
		totalram = totalram.strip()
		totalram = totalram.to_f
		totalram = totalram /10000000000
		totalram = totalram.round(7)
		freeram = freeram.to_f
		freeram = freeram / 10000000
		freeram = freeram.round(7)
		openram = freeram/totalram
		ramper = 1 - openram
		return ramper
	end

end