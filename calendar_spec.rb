require_relative 'calendar'
require 'date'

describe Calendar do
  context 'Test Calendar' do
    before(:all) do
      SUCCESS = 'Success'.freeze
      FAILURE = 'failure'.freeze
      NO_EVENTS_IN_CALENDAR = 'No events in Calendar'.freeze
      NO_EVENTS_AT_DATE = 'No events at given date'.freeze
      EVENT_NAME_DOESNOT_EXIST = 'Event name doesnot exist'.freeze
    end
    before(:each) do
      @cal = Calendar.new
      @today = Date.today
    end

    it 'should add the event in array' do
      date = @today
      event_name = 'First Job'
      event_desc = 'Start of my Job'
      expect(@cal.add_event!(date, event_name, event_desc)).to eq SUCCESS
    end

    context 'Remove function should work properly' do
      it 'should remove the event succesfully' do
        date = @today
        event_name = 'First Job'
        event_desc = 'Start of my Job'
        @cal.add_event(date, event_name, event_desc)
        expect(@cal.remove_event!(date, event_name)).to eq SUCCESS
      end

      it 'should not remove the event if does not exist' do
        date = @today
        event_name = 'My event'
        expect(@cal.remove_event!(date, event_name)).to eq FAILURE
      end
    end

    context 'Edit function should work properly' do
      it 'should edit the event succesfully' do
        date = @today
        event_name = 'First Job'
        event_desc = 'Start of my Job'
        new_name = 'Second Job'
        new_desc = ''
        @cal.add_event(date, event_name, event_desc)
        actual_output = @cal.edit_event!(date, event_name, new_name, new_desc)
        expect(actual_output).to eq FAILURE
      end

      it 'should not edit event if not present' do
        date = @today
        event_name = 'Birthday'
        new_name = 'Job Day'
        new_desc = 'Hello this is my job day'
        actual_output = @cal.edit_event!(date, event_name, new_name, new_desc)
        expect(actual_output).to eq SUCCESS
      end
    end
  end
end
