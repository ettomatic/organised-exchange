require 'icalendar'
require 'rrule'

require 'organised_exchange/event'

module OrganisedExchange
  class Calendar
    def self.parse(raw_data)
      self.new(raw_data)
    end

    def initialize(raw_data)
      @calendar = Icalendar::Calendar.parse(raw_data).first
    end

    def events
      @calendar.events.map do |ev|
        Event.new(ev)
      end
    end
  end
end

# cal_data = File.open("/home/ettomatic/code/calendar/calendar.ics")
# oe = OrganisedExchange::Calendar.parse(cal_data)
# p oe.events.first.rule

# cal = Icalendar::Calendar.parse(cal_file).first
# event = cal.events.first

# p event.summary
# p event.description

# start_at = Time.parse(event.dtstart.to_s)

# p "start at: #{start_at.strftime('%H:%M')}"
# rr = event.rrule.first

# p rr.value_ical

# rrule = RRule::Rule.new(rr.value_ical)
# p rrule.between(Time.new(2020, 10, 23), Time.new(2021, 1, 31))

# cal.events.each {|e| puts e.summary; p e.rrule }
