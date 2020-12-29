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

  describe '#recurrent?' do
    context 'with a recurring event' do
      it 'will return true' do
        expect(subject.recurrent?).to eq true
      end
    end

    context 'witha single event' do
      let(:raw_data)  { File.open('spec/fixtures/non_recurring_event.ics') }

      it 'will return false' do
        expect(subject.recurrent?).to eq false
      end
    end
  end
end
