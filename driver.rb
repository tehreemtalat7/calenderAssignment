# this is the driver file
require 'date'
require_relative 'calendar'
require_relative 'event'

def display_menu
  puts '*-* The Calender Menu *-*'
  puts 'Press 1 to Add Event to Calendar'
  puts 'Press 2 to Remove an Event from Calendar'
  puts 'Press 3 to Edit an Event'
  puts 'Press 4 to print the Calendar'
  puts 'Press 5 to see all events'
  puts 'Press 6 to see events on a date'
  puts 'Press 7 to see events in a month'
  puts 'Press q to exit'
  print 'Your option: '
end

def input_date_from_user
  print 'Enter Date(yyyy-mm-dd): '
  date = gets
  date.chomp!
  Date.parse(date)
rescue ArgumentError
  puts 'Invalid Date! Try Again!'
  puts
  retry
end

def error_message(message)
    puts
    puts '---------------------------------------------------------'
    puts "!!!!!!!!!!!!!!!! #{message} !!!!!!!!!!!!!!!!!!!!"
    puts '---------------------------------------------------------'
    puts
end

def new_line
  puts
end

def start
  input = '4' # default
  C.print_calendar(Date.today.year, Date.today.month)

  while input != 'q'
    new_line
    display_menu
    input = gets
    input = input.chomp
    puts '*****************************'
    new_line

    case input
    when '1'
      puts '----Add Event----'
      new_line
      date = input_date_from_user
      print 'Event Name: '
      event_name = gets
      event_name.chomp!
      print 'Event Description: '
      event_description = gets
      event_description.chomp!
      C.add_event(date, event_name, event_description)

    when '2'
      puts '----Remove Event----'
      if C.events?
        new_line
        date = input_date_from_user
        new_line
        if C.events_at?(date)
          C.show_events_on_date(date)
          print 'Event Name to remove: '
          event_name = gets
          event_name.chomp!
          C.remove_event!(date, event_name)
        else
          error_message('No events at this date')
        end
      else
        error_message('Calendar has no Events!')
      end

    when '3'
      puts '----Edit Event----'
      if C.events?
        new_line
        date = input_date_from_user
        new_line
        if C.events_at?(date)
          C.show_events_on_date(date)
          print 'Event Name to edit: '
          event_name = gets
          event_name.chomp!
          if C.valid_event_name?(event_name)
            puts 'Enter New Details:-'
            puts '{press enter in case you dont want something updated}'
            print 'New Name: '
            new_name = gets
            new_name.chomp!
            print 'New Description: '
            new_desc = gets
            new_desc.chomp!
            C.edit_event!(date, event_name, new_name, new_desc)
          else
            error_message('This event name is invalid!')
          end
        else
          error_message('No events at this date')
        end
      else
        error_message('Calendar has no Events!')
      end

    when '4'
      puts '----Print Calendar----'
      new_line
      print 'Enter year(yyyy): '
      year = gets
      year.chomp!
      print 'Enter month[1-12]: '
      month = gets
      month.chomp!
      C.print_calendar(year.to_i, month.to_i)

    when '5'
      puts '----Your Events----'
      new_line
      C.print_events

    when '6'
      puts '----Your Events on specific date----'
      if C.events?
        new_line
        date = input_date_from_user
        new_line
        C.print_events_on_date(date)
      else
        error_message('Calendar has no Events!')
      end

    when '7'
      puts '----Your Events of a month----'
      new_line
      print 'Enter the month number[1-12]: '
      month = gets
      month.chomp!
      new_line
      C.print_events_of_month(month.to_i)

    when 'q'
      puts '----Exiting----'
      new_line
      return input
    end
  end
end

# main function
C = Calendar.new
start
