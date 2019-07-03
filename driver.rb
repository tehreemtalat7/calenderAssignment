# this is the driver file
require 'date'
require_relative 'calendar'
require_relative 'event'

def displayMenu
  puts "*-* The Calender Menu *-*"
  puts "Press 1 to Add Event to Calendar"
  puts "Press 2 to Remove an Event from Calendar"
  puts "Press 3 to Edit an Event"
  puts "Press 4 to print the Calendar"
  puts "Press 5 to see all events"
  puts "Press 6 to see events on a date"
  puts "Press 7 to see events in a month"
  puts "Press q to exit"
  print "Your option: "
end

def getDate
  begin
    print "Enter Date(yyyy-mm-dd): "
    date = gets
    date.chomp!
    date_given = Date.parse(date)
  rescue ArgumentError
    puts "Invalid Date! Try Again!"
    puts
    retry
  end
end

def errorMessage(message)
    puts
    puts "---------------------------------------------------------"
    puts "!!!!!!!!!!!!!!!! #{message} !!!!!!!!!!!!!!!!!!!!"
    puts "---------------------------------------------------------"
    puts
  end

def newLine
  puts
end

def start
  input = "4" #default
  until input=="q" do
    newLine
    displayMenu
    input = gets
    input = input.chomp
    puts "*****************************"
    newLine

    case input
    when "1"
      puts "----Add Event----"
      newLine
      date = getDate
      print "Event Name: "
      event_name = gets
      event_name.chomp!
      print "Event Description: "
      event_description = gets
      event_description.chomp!
      C.addEvent(date, event_name, event_description)
      #C.printCalendar(date)

    when "2"
      puts "----Remove Event----"
      if C.hasEvents? 
        newLine
        date = getDate
        newLine
        if C.hasEventsAt?(date)
          C.showEventsOnDate(date)
          print "Event Name to remove: "
          event_name = gets
          event_name.chomp!
          C.removeEvent!(date, event_name)
        else
          errorMessage("No events at this date")
        end
      else
        errorMessage("Calendar has no Events!")
      end

    when "3"
      puts "----Edit Event----"
      if C.hasEvents?
        newLine
        date = getDate
        newLine
        if C.hasEventsAt?(date)
          C.showEventsOnDate(date)
          print "Event Name to edit: "
          event_name = gets
          event_name.chomp!
          puts "Enter New Details:-"
          print "New Name:"
          new_name = gets
          new_name.chomp!
          print "New Description:"
          new_desc = gets
          new_desc.chomp!
          C.editEvent!(date, event_name, new_name, new_desc)
        else
          errorMessage("No events at this date")
        end
        
      else
          errorMessage("Calendar has no Events!")
      end

    when "4"
      puts "----Print Calendar----"
      newLine
      date = getDate
      C.printCalendar(date)
      # to print on a month and year provided by user:
      # to do

    when "5"
      puts "----Your Events----"
      newLine
      C.printEvents

    when "6"
      puts "----Your Events on specific date----"
      if C.hasEvents?
        newLine
        date = getDate
        newLine
        C.printEventsOnDate(date)
      else
          errorMessage("Calendar has no Events!")
      end

    when "7"
      puts "----Your Events of a month----"
      newLine
      print "Enter the month number: "
      month = gets
      month.chomp!
      newLine
      C.printEventsOfMonth(month.to_i)

    when "q"
      puts "----Exiting----"
      newLine
      return input
    end
  end
end


# main function
C = Calendar.new
start
