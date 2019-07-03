require_relative 'calendar'
require 'date'

describe Calendar do
  context 'Test Calendar' do
    before(:each) do
      @cal = Calendar.new
      @today = Date.today
    end

    it 'should add the event in array' do
      date = @today
      event_name = 'First Job'
      event_desc = 'Start of my Job'
      expect(@cal.addEvent(date, event_name, event_desc)).to eq 'Succes'
    end

    context 'Remove function should work properly' do
      it 'should remove the event succesfully' do
        date = @today
        event_name = 'First Job'
        event_desc = 'Start of my Job'
        @cal.addEvent(date, event_name, event_desc)
        expect(@cal.removeEvent!(date, event_name)).to eq 'Success'
      end

      it 'should not remove the event if does not exist' do
        date = @today
        event_name = 'My event'
        expect(@cal.removeEvent!(date, event_name)).to eq 'failure'
      end
    end

    context 'Edit function should work properly' do
      it 'should edit the event succesfully' do
        date = @today
        event_name = 'First Job'
        event_desc = 'Start of my Job'
        new_name = 'Second Job'
        new_desc = ''
        @cal.addEvent(date, event_name, event_desc)
        actual_output = @cal.editEvent!(date, event_name, new_name, new_desc)
        expect(actual_output).to eq 'Success'
      end

      it 'should not edit event if not present' do
        date = @today
        event_name = 'Birthday'
        new_name = 'Job Day'
        new_desc = 'Hello this is my job day'
        actual_output = @cal.editEvent!(date, event_name, new_name, new_desc)
        expect(actual_output).to eq 'failure'
      end
    end
  end
end
