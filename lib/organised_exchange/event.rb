require 'forwardable'

module OrganisedExchange
  class Event
    extend Forwardable
    def_delegators :@cal_event, :summary, :dtstart, :dtend

    attr_accessor :date

    def initialize(cal_event)
      @cal_event = cal_event
    end

    def scheduled_at
      @date.strftime("%Y-%m-%d %a ") + @cal_event.dtstart.strftime("%H:%M-") + @cal_event.dtend.strftime("%H:%M")
    end
  end
end
