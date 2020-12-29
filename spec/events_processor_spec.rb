# frozen_string_literal: true

require 'spec_helper'

describe OrganisedExchange::EventsProcessor do
  subject          { described_class }
  let(:raw_data)   { File.open('spec/fixtures/calendar.ics') }
  let(:cal_events) { Icalendar::Calendar.parse(raw_data).first.events }

  describe '.process' do
    it 'will generate an array of Events' do
      events = subject.process(cal_events)
      expect(events.first).to be_a(OrganisedExchange::Event)
    end

    it 'will generate an array of Events, one for each future occurrence' do
      events = subject.process(cal_events)
      expect(events.size).to eq 3
      events = subject.process(cal_events, 30.days)
      expect(events.size).to eq 5
    end

    it 'will generate an array of Events sorted by date' do
      events = subject.process(cal_events)
      expect(events.first.scheduled_at).to eq '2020-12-31 Thu 14:00-17:00'
      expect(events.second.scheduled_at).to eq '2021-01-01 Fri 10:30-11:00'
      expect(events.third.scheduled_at).to eq '2021-01-08 Fri 10:30-11:00'
    end

    it 'will generate an array of Events, each scheduled for one of the occurrences' do
      events = subject.process(cal_events)
      expect(events.second.scheduled_at).to eq '2021-01-01 Fri 10:30-11:00'
    end

    it 'will handle non recurring events, using the dtstart property as scheduled date' do
      events = subject.process(cal_events)
      expect(events.first.scheduled_at).to eq '2020-12-31 Thu 14:00-17:00'
    end
  end
end
