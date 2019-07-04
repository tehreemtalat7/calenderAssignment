# this is the driver file
require 'date'
require_relative 'calendar'
require_relative 'event'

ADD_EVENT = '1'.freeze
REMOVE_EVENT = '2'.freeze
EDIT_EVENT = '3'.freeze
PRINT_CALENDAR = '4'.freeze
SHOW_ALL_EVENTS = '5'.freeze
SHOW_EVENTS_ON_A_DATE = '6'.freeze
SHOW_EVENTS_OF_MONTH = '7'.freeze
EXIT = 'q'.freeze

def display_menu
  puts "\n\n*-* The Calender Menu *-*"
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

def press_enter_for_menu
  puts '--Press any key to go back to Menu..'
  gets
end

def input_date_from_user
  print 'Enter Date(yyyy-mm-dd): '
  date = gets
  date.chomp!.strip!
  Date.parse(date)
rescue ArgumentError
  puts "Invalid Date! Try Again!\n\n"
  retry
end

def error_message(message)
  puts "\n\n-------------------------------------------------------"
  puts "!!!!!!!!!!!!!!!! #{message} !!!!!!!!!!!!!!!!!!!!\n\n"
  puts "---------------------------------------------------------\n\n"
end

def start
  input = PRINT_CALENDAR # default
  C.print_calendar(Date.today.year, Date.today.month)

  while input != EXIT
    display_menu
    input = gets
    input.chomp!.strip!
    puts "*****************************\n\n"

    case input
    when ADD_EVENT
      puts "----Add Event---- \n\n"
      date = input_date_from_user
      print 'Event Name: '
      event_name = gets
      event_name.chomp!.strip!
      print 'Event Description: '
      event_description = gets
      event_description.chomp!.strip!
      puts C.add_event!(date, event_name, event_description)
      press_enter_for_menu

    when REMOVE_EVENT
      puts "----Remove Event----\n\n"
      if C.events?
        date = input_date_from_user
        C.show_events_on_date(date)
        print 'Event Name to remove: '
        event_name = gets
        event_name.chomp!.strip!
        puts C.remove_event!(date, event_name)
      else
        error_message('Calendar has no Events!')
      end
      press_enter_for_menu

    when EDIT_EVENT
      puts "----Edit Event----\n\n"
      if C.events?
        date = input_date_from_user
        C.show_events_on_date(date)
        print 'Event Name to edit: '
        event_name = gets
        event_name.chomp!.strip!
        puts 'Enter New Details:-'
        puts '{press enter in case you dont want something updated}'
        print 'New Name: '
        new_name = gets
        new_name.chomp!.strip!
        print 'New Description: '
        new_desc = gets
        new_desc.chomp!.strip!
        puts C.edit_event!(date, event_name, new_name, new_desc)
      else
        error_message('Calendar has no Events!')
      end
      press_enter_for_menu

    when PRINT_CALENDAR
      puts "----Print Calendar----\n\n"
      print 'Enter year(yyyy): '
      year = gets
      year.chomp!.strip!
      print 'Enter month[1-12]: '
      month = gets
      month.chomp!.strip!
      C.print_calendar(year.to_i, month.to_i)
      press_enter_for_menu

    when SHOW_ALL_EVENTS
      puts "----Your Events----\n\n"
      C.print_all_events
      press_enter_for_menu

    when SHOW_EVENTS_ON_A_DATE
      puts "----Your Events on specific date----\n\n"
      if C.events?
        date = input_date_from_user
        C.print_events_on_date(date)
      else
        error_message('Calendar has no Events!')
      end
      press_enter_for_menu

    when SHOW_EVENTS_OF_MONTH
      puts "----Your Events of a month----\n\n"
      print 'Enter the month number[1-12]: '
      month = gets
      month.chomp!.strip!
      C.print_events_of_month(month.to_i)
      press_enter_for_menu

    when EXIT
      puts "----Exiting----\n\n"
      return input
    end
  end
end

# main function
C = Calendar.new
start
