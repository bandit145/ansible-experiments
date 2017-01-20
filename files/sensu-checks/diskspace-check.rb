#!/usr/bin/env ruby
#this will work unless the system has more than one ext4 part
require 'sensu-plugin/check/cli' 

class DiskSpace < Sensu::Plugin::Check::CLI

	option :warn,
	short: '-w WARN',
	proc: proc {|a| a.to_f},
	default: 80

	option :crit,
	short: '-c CRIT',
	proc: proc {|a| a.to_f},
	default: 90

	option :sys,
	short: '-s SYS',
	proc: proc {|a| a.to_s},
	default: 'ext4'

	def run
		io = IO.popen("df -t "+config[:sys]+" | awk 'FNR == 2 {print $5}'")
		diskuse =  io.read()
		diskuse = diskuse.tr('%','')
		diskuse = diskuse.to_i

		critical(diskuse.to_s+'%') if diskuse > config[:crit]
		warning(diskuse.to_s+'%') if diskuse > config[:warn]
		ok(diskuse.to_s+'%')
	end
end