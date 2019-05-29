#!/usr/bin/env ruby
require 'amex'

class Expronzo
	attr_reader :client

	unless ENV['amexu'] and ENV['amexp']
		raise "ur amex username and password must be available in" +
			"the environmental variables 'amexu' and 'amexp'."
	end

	def initialize
		@accounts = Amex::Client.
			new(ENV['amexu'], ENV['amexp'])
			.accounts

		@accounts.each do |account|
			puts account.transactions.inspect
		end
	end
end

Expronzo.new
