# frozen_string_literal: true

require 'forwardable'

module OrganisedExchange
  class Event
    extend Forwardable
    def_delegators :@cal_event, :summary, :dtstart, :dtend, :description

    attr_accessor :date

    def initialize(cal_event)
      @cal_event = cal_event
    end

    def scheduled_at
      @date.strftime('%Y-%m-%d %a ') + @cal_event.dtstart.strftime('%H:%M-') + @cal_event.dtend.strftime('%H:%M')
    end

    def to_org
      "* #{summary}\nSCHEDULED: <#{scheduled_at}>\n#{description}\n"
    end
  end
end
