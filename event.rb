# Public: this is a class for events
#
# A class to contain name and description of events
class Event
  attr_accessor :name, :description

  def initialize(name, description)
    @name = name
    @description = description
  end

  def to_s
    puts "Event: #{@name}"
    puts "-- #{description}"
  end
end
