#!/usr/bin/env ruby

require_relative '../lib/organised_exchange'

origin      = ENV['ORGANISED_EXCHANGE_ORIGIN']
destination = ENV['ORGANISED_EXCHANGE_DESTINATION'] || STDOUT

raise "Origin not set, please set the ORGANISED_EXCHANGE_ORIGIN env var" unless  origin

cal_data = File.open(origin)

calendar = OrganisedExchange::Calendar.parse(cal_data)

calendar.process
calendar.to_org(destination)
