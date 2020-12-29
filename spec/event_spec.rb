# frozen_string_literal: true

require 'spec_helper'

describe OrganisedExchange::Event do
  subject         { described_class.new(cal_event) }
  let(:raw_data)  { File.open('spec/fixtures/event.ics') }
  let(:cal_event) { Icalendar::Event.parse(raw_data).first }

  describe '#summary' do
    it 'will delegate to the iCalendar Event' do
      expect(subject.summary).to eq 'Joe 1:1'
    end
  end

  describe '#scheduled_at' do
    it 'will return the scheduled date and time' do
      subject.date = Time.new('2021-01-01 Fri 10:30:00')
      expect(subject.scheduled_at).to eq '2021-01-01 Fri 10:30-11:00'
    end
  end

  describe '#to_org' do
    it 'will return the scheduled date and time' do
      subject.date = Time.new('2021-01-01 Fri 10:30:00')

      expected = "* Joe 1:1
SCHEDULED: <2021-01-01 Fri 10:30-11:00>
HI Joe,

To discuss how things are going, what you’re enjoying and not, etc.  We can start with 30 minutes and see whether we need more or less time.

Cheers
"
      expect(subject.to_org).to eq expected
    end
  end
end
