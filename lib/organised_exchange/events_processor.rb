module OrganisedExchange
  class EventsProcessor
    def self.process(cal_events, window = 14.days)
      cal_events.map do |ev|
        ev_rules = rules(ev)
        if ev_rules
          ev_rules.between(Time.now, Time.now + window).map do |dt|
            event = Event.new(ev)
            event.date = dt
            event
          end
        else
          event = Event.new(ev)
          event.date = ev.dtstart
          event
        end
      end.flatten
    end

    def self.rules(cal_event)
      return if cal_event.rrule.empty?
      RRule::Rule.new(cal_event.rrule.first.value_ical)
    end
  end
end
