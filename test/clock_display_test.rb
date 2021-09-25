# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/clock_display'
require 'test/unit'

class ClockTest < Test::Unit::TestCase
  def test_zero
    clock = Clock.new(0, 0, 0)
    output = clock.print_string
    assert_equal('00:00:00', output)
  end

  def test_increment_from_zero
    clock = Clock.new(0, 0, 0)
    clock.increment
    output = clock.print_string
    assert_equal('00:00:01', output)
  end

  def test_increment_from_59_seconds
    clock = Clock.new(0, 0, 59)
    clock.increment
    output = clock.print_string
    assert_equal('00:01:00', output)
  end

  def test_increment_from_59_min
    clock = Clock.new(0, 59, 59)
    clock.increment
    output = clock.print_string
    assert_equal('01:00:00', output)
  end

  def test_increment_from_23_hours
    clock = Clock.new(23, 59, 59)
    clock.increment
    output = clock.print_string
    assert_equal('00:00:00', output)
  end

  def test_increment_from_happy_sec
    clock = Clock.new(0o2, 23, 13)
    clock.increment
    output = clock.print_string
    assert_equal('02:23:14', output)
  end

  def test_increment_to_next_min
    clock = Clock.new(0o2, 23, 59)
    clock.increment
    output = clock.print_string
    assert_equal('02:24:00', output)
  end

  def test_increment_to_next_hour
    clock = Clock.new(12, 59, 59)
    clock.increment
    output = clock.print_string
    assert_equal('13:00:00', output)
  end
end
