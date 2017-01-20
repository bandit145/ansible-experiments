#!/usr/bin/env ruby
#check cpu
#define class and inherit from sensu cli
#gem
require 'sensu-plugin/check/cli'
class SERVICE < Sensu::Plugin::Check::CLI
	option :serv,
	short: '-s SERVICE',
	proc: proc {|a| a.to_str}


	def run
		if RUBY_PLATFORM.include? 'mingw32'
			status = windows()
		elsif RUBY_PLATFORM.include? 'linux'
			status = linux()
		end
			
	 	ok if status == 'ok'
	 	critical(config[:serv]+' is not running')if status =='dead'
  	end

  	def windows
  		io = IO.popen("sc query"+config[:serv])
  		service = io.read
  		if not service.include? 'RUNNING'
  			status = 'dead'
  		else
  			status = 'ok'
  		end
  		return status
  	end
  	def linux
  		io = IO.popen("service "+config[:serv]+" status")
		service = io.read()
		if not service.include? 'active (running)'
			status =  'dead'
		else
			status = 'ok'
		end
		return status
	end

end