# frozen_string_literal: true

module OrganisedExchange
  class EventsProcessor
    def self.process(cal_events, window = 14.days)
      cal_events.map do |ev|
        ev_rules = rules(ev)

        if ev_rules
          ev_rules.between(Time.now, Time.now + window).map do |dt|
            event = Event.new(ev)
            event.date = dt.to_time
            event
          end
        else
          next unless ev.dtstart > Time.now
          event = Event.new(ev)
          event.date = ev.dtstart.to_time
          event
        end
      end.flatten.compact.uniq.sort_by(&:date)
    end

    def self.rules(cal_event)
      return if cal_event.rrule.empty?

      RRule::Rule.new(cal_event.rrule.first.value_ical)
    end
  end
end
