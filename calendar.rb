# this is the calender class
require 'date'
require 'time'
require_relative 'event'

# Public: Class for Calendar
#
# MONTHS  - Array of months in full form.
# count - A hash conatining events as a value to a key(date)
#
# Performs Add, Remove, Edit, Print functions
class Calendar

  MONTHS = Date::MONTHNAMES
  SUCCESS = 'Success'.freeze
  FAILURE = 'failure'.freeze
  NO_EVENTS_IN_CALENDAR = 'No events in Calendar'.freeze
  NO_EVENTS_AT_DATE = 'No events at given date'.freeze
  EVENT_NAME_DOESNOT_EXIST = 'Event name doesnot exist'.freeze

  def initialize
    @calendar_events = Hash.new({})
  end

  # Public
  # returns Event object if added else nil
  def add_event!(date, event_name, ev_description)
    return nil if event_name.empty?

    @calendar_events[date] = {} unless events_at?(date)
    @calendar_events[date][event_name] = ev_description
    Event.new(event_name, ev_description)
  end

  # Public
  # returns success if removed else error string
  def remove_event!(date, event_name)
    return NO_EVENTS_AT_DATE unless events_at?(date)
    return EVENT_NAME_DOESNOT_EXIST unless event_name_exists?(date, event_name)

    events_on_date = @calendar_events[date]
    events_on_date.delete(event_name)
    @calendar_events.delete(date) if events_on_date.empty?
    SUCCESS
  end

  # Public
  # returns success if edited else error string
  def edit_event!(date, event_name, new_name, new_desc)
    return NO_EVENTS_IN_CALENDAR unless events?
    return NO_EVENTS_AT_DATE unless events_at?(date)
    return EVENT_NAME_DOESNOT_EXIST unless event_name_exists?(date, event_name)

    events_on_date = @calendar_events[date]

    events_on_date[event_name] = new_desc unless new_desc.empty?
    unless new_name.empty?
      events_on_date[new_name] = events_on_date.delete event_name
      events_on_date.delete(event_name)
    end
    SUCCESS
  end

  # Public
  # returns the hash containing events on give date else nil
  def show_events_on_date(date)
    return nil unless events_at?(date)

    events = @calendar_events[date]
    puts 'You have following events on this date:'
    print_events(events)
    events
  end

  # Public
  # prints all events, if no events returns error string
  def print_all_events
    return NO_EVENTS_IN_CALENDAR unless events?

    @calendar_events.each do |date, events|
      puts "On date #{date}:"
      print_events(events)
    end
  end

  # Public
  # Prints the events, as given in a hash
  def print_events(events)
    events.each do |name, description|
      puts "Event: #{name}"
      puts "Description: #{description} \n\n"
    end
  end

  # Public
  # prints the events on a given date, else returns error code
  def print_events_on_date(date)
    return NO_EVENTS_IN_CALENDAR unless events?
    return NO_EVENTS_AT_DATE unless events_at?(date)

    events = @calendar_events[date]
    puts "Your events on #{date}"
    print_events(events)
  end

  # Public
  # print the events of a certain month, else returns error string
  def print_events_of_month(month)
    return NO_EVENTS_IN_CALENDAR unless events?

    puts "The events of #{MONTHS[month]}"
    @calendar_events.each do |date, events_hash|
      next if date.month != month
      print_events(events_hash)
    end
  end

  # Public
  # prints the calnedar in month format
  def print_calendar(year, month)
    week_day = Date.new(year, month, 1).cwday
    month_length = days_in_month(year, month)
    line = ["Sun\tMon\tTues\tWed\tThurs\tFri\tSat"]
    days = (1..month_length).to_a
    week_day.times { days.unshift("\t") }

    puts
    puts line
    days.each_slice(7) do |week|
      week.each do |day|
        print day

        # check if there is a event at this date
        unless day == "\t"
          curr_date = Date.new(year, month, day.to_i)
          if @calendar_events.key?(curr_date)
            count = @calendar_events[curr_date].size
            print "[#{count}]"
          end
        end

        print "\t" unless day == "\t"
      end
      puts
    end
    puts
  end

  # Public
  # returns true if calendar has events, false otherwise
  def events?
    !@calendar_events.empty?
  end

  # Public
  # returns true if there are events at given date, false otherwise
  def events_at?(date)
    !@calendar_events[date].empty?
  end

  private

  # Private
  # returns true if a events with given name is in calendar, false otherwise
  def event_name_exists?(date, event_name)
    false if !events? || !events_at?(date)
    @calendar_events[date].key?(event_name)
  end

  # Private
  # returns number of days in a month
  def days_in_month(year, month)
    Date.new(year, month, -1).day
  end
end
