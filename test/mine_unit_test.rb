# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/board_controller'
require_relative '../lib/board_model'
require 'test/unit'

class MineUnitTest < Test::Unit::TestCase
   
  def test_define_bordering
       @board = Board.new()
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
    new_board = Board.new()
    board = new_board.board
    (0..board.length-1).each do |box_index|
      if board[box_index-1][:value] == '💣'
        next
      else
        # Si no es bomba lo revelamos
        board[box_index][:revealed?] = true
      end
    end
    assert_true(new_board.win())
  end

end