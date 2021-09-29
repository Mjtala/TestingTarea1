# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/board_controller'
require_relative '../lib/board_model'
require 'test/unit'

# Testeo de minesweeper
class MineUnitTest < Test::Unit::TestCase
  def test_define_bordering
    @board = Board.new
    output = @board.define_bordering
    expected = [
      [-1, -1], # upper-left
      [-1, 0], # top
      [-1, 1], # upper-right
      [0, 1], # right
      [1, 1], # lower-right
      [1, 0], # bottom
      [1, -1], # lower-left
      [0, -1] # left
    ]
    assert_equal(expected, output)
  end

  def test_win
    @board = Board.new
    # revisar como verificar posicion de bombas
  end

  def test_define_bordering_cross
    @board = Board.new
    output = @board.define_bordering_cross
    expected = [
      [-1, 0], # top
      [0, 1], # right
      [1, 0], # bottom
      [0, -1] # left
    ]
    assert_equal(expected, output)
  end
end
