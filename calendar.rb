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
  @@MONTHS = Date::MONTHNAMES

  def initialize
    @events_list = Hash.new(0)
  end

  def add_event(date, ev_name, ev_description)
    new_event = Event.new(ev_name, ev_description)
    unless @events_list.key?(date)
      # Create an key and create array in front of it
      # then add the first event in the array
      @events_list[date] = []
    end
    @events_list[date] << new_event
    ending_line('Event Added Successfully!')
    go_back
    'Success'
  end

  def remove_event!(date, ev_name)
    result = 'failure'
    if @events_list.key?(date)
      ev = @events_list[date]
      ev.each do |e|
        if e.name == ev_name
          # remove it
          ev.delete(e)
          ending_line('Event Removed Successfully!')
          if ev.empty?
            @events_list.delete(date)
          end
          result = 'Success'
        else
          error_message('This event name is invalid!')
        end
      end
    end
    go_back
    result
  end

  def edit_event!(date, ev_name, new_name, new_desc)
    result = 'failure'
    if @events_list.key?(date)
      ev = @events_list[date]
      ev.each do |e|
        if e.name == ev_name
          # update the event
          unless new_name.empty?
            e.name = new_name
          end
          unless new_desc.empty?
            e.description = new_desc
          end
          ending_line('Event Edited Successfully!')
          result = 'Success'
        else
          error_message('This event name is invalid!')
        end
      end
    end
    go_back
    result
  end

  def show_events_on_date(date)
    if @events_list.key?(date)
      ev = @events_list[date]
      puts 'You have following events on this date:'
      ev.each(&:to_s)
      puts
    end
  end

  def print_events
    if @events_list.empty?
      ending_line('No events in Calendar')
    else
      @events_list.each do |key, value|
        puts "On date #{key}:"
        value.each do |ev|
          ev.to_s
          puts
        end
      end
    end
    go_back
  end

  def print_events_on_date(date)
    if @events_list.empty?
      error_message('No events in Calendar')
    else
      ev = @events_list[date]
      if ev.empty?
        error_message("No events at #{date}")
      else
        puts "Your events on #{date}"
        ev.each do |event|
          event.to_s
          puts
        end
      end
    end
    go_back
  end

  def print_events_of_month(month)
    # to do
    if @events_list.empty?
      error_message('No events in Calendar')
    else
      @events_list.each do |key, _|
        if key.month == month
          ev = @events_list[key]
          puts "The events of #{@@MONTHS[month]}"
          ev.each do |event|
            event.to_s
            puts
          end
        end
      end
    end
    go_back
  end

  def print_calendar(year, month)
    week_day = Date.new(year, month, 1).cwday
    month_length = days_in_month(year, month)
    line = ["Sun\tMon\tTues\tWed\tThurs\tFri\tSat"]
    days = (1..month_length).to_a
    week_day.times { days.unshift("\t") }

    puts
    puts "#{@@MONTHS[month]} #{year}"
    puts line
    days.each_slice(7) do |week|
      week.each do |d|
        print d

        # check if there is a event at this date
        unless d == "\t"
          curr_date = Date.new(year, month, d.to_i)
          if @events_list.key?(curr_date)
            count = @events_list[curr_date].size
            print "[#{count}]"
          end
        end

        print "\t" unless d == "\t"
      end
      puts
    end
    puts
    go_back
  end

  def events?
    if @events_list.empty?
      false
    else
      true
    end
  end

  def events_at?(date)
    if @events_list[date].empty?
      false
    else
      true
    end
  end

  def valid_event_name?(e_name)
    result = false
    if events?
      @events_list.each do |_, events|
        events.each do |event|
          # puts "event_name: #{event.name}, e_name: #{e_name}"
          result = true if event.name == e_name
        end
      end
    end
    result
  end

  def no_events?
    if @events_list.empty?
      true
    else
      false
    end
  end

  private

  def days_in_month(year, month)
    Date.new(year, month, -1).day
  end

  def ending_line(message)
    puts
    puts '---------------------------------------------------------'
    puts "---------------#{message}----------------"
    puts '---------------------------------------------------------'
    puts
  end

  def error_message(message)
    puts
    puts '--------------------------------------------------------'
    puts "!!!!!!!!!!!!!!!!!!!!#{message}!!!!!!!!!!!!!!!!!!"
    puts '---------------------------------------------------------'
    puts
  end

  def go_back
    puts '--Press any key to go back to Menu..'
    gets
  end
end
