# frozen_string_literal: true
require 'icalendar'
require 'rrule'

require_relative 'organised_exchange/event'
require_relative 'organised_exchange/events_processor'

module OrganisedExchange
  class Calendar
    def self.parse(raw_data)
      new(raw_data)
    end

    def initialize(raw_data)
      @calendar = Icalendar::Calendar.parse(raw_data).first
      @events = []
    end

    def process
      @events = EventsProcessor.process(@calendar.events)
    end

    def to_org(destination)
      if destination == STDOUT
        print(STDOUT)
      else
        File.open(destination, "w+") do |f|
          print(f)
        end
      end
    end

    def print(target)
      target.puts "#+STARTUP: overview\n\n"
      @events.each { |ev| target.puts(ev.to_org) }
    end
  end
end
