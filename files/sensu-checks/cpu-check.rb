#!/usr/bin/env ruby
#check cpu
#define class and inherit from sensu cli
#gem
require 'sensu-plugin/check/cli'
class CPU < Sensu::Plugin::Check::CLI

	option :warn,
	short: '-w WARN',
	proc: proc {|a| a.to_i},
	default: 70

	option :crit,
	short: '-c CRIT',
	proc: proc {|a| a.to_i},
	default: 80

	def run
		if RUBY_PLATFORM.include? 'mingw32'
			cpuper = windows()
		elsif RUBY_PLATFORM.include? 'linux'
			cpuper = linux()
		end
	 	critical((cpuper.to_i).to_s+'%')if cpuper > config[:crit] 
	 	warning((cpuper.to_i).to_s+'%') if cpuper > config[:warn]  
	 	ok((cpuper.to_i).to_s+'%')
  	end

  	def windows
  		io = IO.popen "wmic cpu get loadpercentage"
  		cpuper = io.read()
  		cpuper = cpuper.strip()
  		cpuper = cpuper.tr('LoadPercentage','')
  		cpuper = cpuper.strip()
  		cpuper = cpuper.to_i
  		return cpuper
  	end
  	
  	def linux
  		io = IO.popen "top -bn 2 -d 0.01 | grep 'Cpu(s)' | tail -n 1 | awk '{print $2+$4+$6}'"
		cpuper = io.read()
		cpuper = cpuper.to_f
		return cpuper
	end


end