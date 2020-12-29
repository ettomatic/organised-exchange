require_relative './lib/organised_exchange'

origin      = ENV['ORGANISED_EXCHANGE_ORIGIN']
destination = ENV['ORGANISED_EXCHANGE_DESTINATION']

raise 'missing env variables' unless origin && destination

cal_data = File.open(origin)

calendar = OrganisedExchange::Calendar.parse(cal_data)

puts 'Processing...'

calendar.process
calendar.to_org(destination)
