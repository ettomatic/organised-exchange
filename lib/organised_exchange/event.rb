require 'forwardable'

module OrganisedExchange
  class Event
    extend Forwardable
    def_delegators :@cal_event, :summary, :dtstart, :dtend

    def initialize(cal_event)
      @cal_event = cal_event
    end

    def recurrent?
      !rule.nil?
    end

    # this probably need to be done before initialising the Event
    def scheduled
      rule.between(Time.now, Time.now + 14.days).map do |dt|
        dt.strftime("%Y-%m-%d %a ") + @cal_event.dtstart.strftime("%H:%M-") + @cal_event.dtend.strftime("%H:%M")
      end
    end

    def rule
      return if @cal_event.rrule.empty?

      RRule::Rule.new(@cal_event.rrule.first.value_ical)
    end
  end
end
