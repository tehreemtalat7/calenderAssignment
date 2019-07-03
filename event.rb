# this is a class for events

class Event

  attr_accessor :name, :description

  def initialize(ename, description)
    @name = ename
    @description = description
  end

  def to_s
    puts "Event: #{@name}"
    puts "-- #{description}"
  end

end