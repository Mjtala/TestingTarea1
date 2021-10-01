# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/board_controller'
require_relative '../lib/board_model'
require_relative '../lib/board_view'
require 'test/unit'

# Testeo de minesweeper
class MineUnitTest < Test::Unit::TestCase
  def test_reveal_boxes_move
    new_board = Board.new(3, 1)
    board = new_board.board
    (0..board.length - 1).each do |box_index|
      next unless board[box_index][:value] != '💣' && (board[box_index][:value]).zero?

      row, col = new_board.get_coordinates(box_index)
      new_board.reveal(row, col)
      break
    end
    assert_false(new_board.game_over)
  end

  def test_game_over
    new_board = Board.new
    board = new_board.board
    (0..board.length - 1).each do |box_index|
      if board[box_index][:value] == '💣'
        row, col = new_board.get_coordinates(box_index)
        new_board.reveal(row, col)
        break
      else
        next
      end
    end
    assert_true(new_board.game_over)
  end

  def test_win
    new_board = Board.new
    board = new_board.board
    (0..board.length - 1).each do |box_index|
      if board[box_index][:value] != '💣'
        # Si no es bomba lo revelamos
        board[box_index][:revealed?] = true
      end
    end
    assert_true(new_board.win)
  end

  def test_request_negative_input
    new_board = Board.new
    board_view = BoardView.new
    board_controller = BoardController.new(new_board, board_view)
    x = -3
    y = -3 
    assert_equal(board_view.send_error_message, board_controller.request_input(x,y))
  end

  def test_request_out_of_range_input
    new_board = Board.new
    board_view = BoardView.new
    board_controller = BoardController.new(new_board, board_view)
    x = (new_board.width + 4).to_i
    y = (new_board.width + 4).to_i
    assert_equal(board_view.send_error_message, board_controller.request_input(x,y))
  end

#   def test_request_correct_input
#     new_board = Board.new
#     board_view = BoardView.new
#     board_controller = BoardController.new(new_board, board_view)
#     x = 4
#     y = 2
#     expected = [x,y]
#     input = board_controller.request_input(x,y)
#     assert_equal(expected, input)
#     # assert_equal(y, value_y)
#   end

  def test_print_board
    # No se hace porque es de la view
  end

  def play
    
  end
  
end
