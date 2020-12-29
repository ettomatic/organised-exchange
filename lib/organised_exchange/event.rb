require 'forwardable'

module OrganisedExchange
  class Event
    extend Forwardable
    def_delegator :@cal_event, :summary

    def initialize(cal_event)
      @cal_event = cal_event
    end

    def recurrent?
      !rule.nil?
    end

    def rule
      return if @cal_event.rrule.empty?

      RRule::Rule.new(@cal_event.rrule.first.value_ical)
    end
  end
end
