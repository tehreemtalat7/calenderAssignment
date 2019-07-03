# this is the calender class
require 'date'
require 'time'
#require 'chronic'
#require 'active_support/all'
require_relative 'event'

class Calendar
  
  @@MONTHS = Date::MONTHNAMES

  def initialize
    @events_list = Hash.new(0)
  end

  public
  def addEvent(date, ev_name, ev_description)
    new_event = Event.new(ev_name, ev_description)
    if @events_list.has_key?(date)
      # Hash already has this key, add in the array
      @events_list[date] << new_event
    else
      # Create an key and create array in front of it
      # then add the first event in the array
      @events_list[date] = []
      @events_list[date] << new_event
    end
    endingLine("Event Added Successfully!")
    goBack
    return "Success"
  end

  def removeEvent!(date, ev_name)
    result = "failure"
    if @events_list.has_key?(date)
      ev = @events_list[date]
      ev.each do |e|
        if e.name == ev_name
          # remove it
          ev.delete(e)
          endingLine("Event Removed Successfully!")
          if ev.empty?
            # if this event was single item against d, 
            # delete key d from hash as well
            @events_list.delete(date)
          end
          result = "Success"
        else
          errorMessage("This event name is invalid!")
        end
      end
    end
    goBack
    result
  end

  def editEvent!(date, ev_name, new_name, new_desc)
    result = "failure"
    if @events_list.has_key?(date)
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
          endingLine("Event Edited Successfully!")
          result = "Success"
        else
          errorMessage("This event name is invalid!")
        end
      end
    end
    goBack
    result
  end

  def showEventsOnDate(date)
    if @events_list.has_key?(date)
      ev = @events_list[date]
      puts "You have following events on this date:"
      ev.each { |x| x.to_s }
      puts
    end
  end

  def printEvents
    # prints all events of a person
    if @events_list.empty?
      endingLine("No events in Calendar")
    else
      @events_list.each do |key, value| 
        puts "On date #{key}:"
        value.each do |ev|
          ev.to_s
        puts
        end 
      end
    end
    goBack
  end

  def printEventsOnDate(d)
    if @events_list.empty?
      errorMessage("No events in Calendar")
    else
      ev = @events_list[d]
      if ev.empty?
        errorMessage("No events at #{d.to_s}")
      else
        puts "Your events on #{d.to_s}"
        ev.each do |event|
          event.to_s
          puts
        end 
      end
    end
    goBack
  end

  def printEventsOfMonth(month)
    # to do
    if @events_list.empty?
      errorMessage("No events in Calendar")
    else
      @events_list.each do |key,value|
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
    goBack
  end

  def printCalendar(date)
    # print the Calender in Month form
    month = date.month
    year = date.year
    week_day = Date.new(year,month,1).cwday
    puts "week day: #{week_day}"
    month_length = days_in_month(year, month)
    line = ["Sun\tMon\tTues\tWed\tThurs\tFri\tSat"]
    days = (1..month_length).to_a
    (week_day).times { days.unshift("\t") }

    puts
    puts "#{@@MONTHS[date.month]} #{year}"
    puts line 
    days.each_slice(7) do |week|
      week.each do |d|
        print d
        unless d=="\t"
          print "\t"
        end
      end
      puts
    end
    puts
    goBack
  end

  def hasEvents?
    if @events_list.empty?
      r = false
    else
      r = true
    end
  end

  def hasEventsAt?(date)
    if @events_list[date].empty?
      r = false
    else
      r = true
    end
  end

  def noEvents?
    if @events_list.empty?
      r = true
    else
      r = false
    end
  end

  private
  def days_in_month(year, month)
    Date.new(year, month, -1).day
  end

  def format_calendar offset, month_length
    lines = [ "Sun Mon Tue Wed Thu Fri Sat" ]
    dates = [nil] * offset + (1..month_length).to_a
    dates.each_slice(7) do |week|
      lines << week.map { |date| date.to_s.rjust(3) }.join(' ')
    end
    lines.join("\n")

  end

  def endingLine(message)
    puts
    puts "---------------------------------------------------------"
    puts "---------------#{message}----------------"
    puts "---------------------------------------------------------"
    puts
  end

  def errorMessage(message)
    puts
    puts "--------------------------------------------------------"
    puts "!!!!!!!!!!!!!!!!!!!!#{message}!!!!!!!!!!!!!!!!!!"
    puts "---------------------------------------------------------"
    puts
  end

  def goBack
    puts "--Press any key to go back to Menu.."
    go_back = gets
  end

end