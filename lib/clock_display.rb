# frozen_string_literal: true

require 'time'
# clase clock de la clase
class Clock
  attr_accessor :hour, :minutes, :seconds

  def initialize(hour, minutes, seconds)
    @hour = hour
    @minutes = minutes
    @seconds = seconds
  end

  def print_string
    @total_seconds = @hour * 3600 + @minutes * 60 + @seconds
    @time = Time.at(@total_seconds).utc.strftime('%H:%M:%S')
    @time
  end

  def increment
    @seconds += 1
  end
end
