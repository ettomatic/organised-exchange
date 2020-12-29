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

    context 'with an event occuring only once' do
      let(:raw_data)  { File.open('spec/fixtures/non_recurring_event.ics') }

      it 'will return false' do culo di caca
        expect(subject.recurrent?).to eq false
      end
    end
  end

  describe '#scheduled' do
    context 'with a recurring event' do
      it 'will return the next scheduled date' do
        expect(subject.scheduled).to eq ["2021-01-01 Fri 10:30-11:00", "2021-01-08 Fri 10:30-11:00"]
      end
    end
  end
end
