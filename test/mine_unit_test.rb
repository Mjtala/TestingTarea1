# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/board_controller'
require_relative '../lib/board_model'
require 'test/unit'

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

    def test_reveal_boxes_move
        new_board = Board.new(3, 1)
        board = new_board.board
        (0..board.length-1).each do |box_index|
            if board[box_index][:value] != '💣' 
                if (board[box_index][:value]).zero? 
                    row, col = new_board.get_coordinates(box_index)
                    new_board.reveal(row, col)
                    break
                end
            end
        end
        assert_false(new_board.game_over())
    end

    
    def test_game_over
        new_board = Board.new()
        board = new_board.board
        (0..board.length-1).each do |box_index|
            if board[box_index][:value] == '💣'
                row, col = new_board.get_coordinates(box_index)
                new_board.reveal(row, col)
                break
            else
                next
            end
        end
        assert_true(new_board.game_over())
    end

    def test_win
        new_board = Board.new()
        board = new_board.board
        (0..board.length-1).each do |box_index|
            if board[box_index][:value] != '💣'
                # Si no es bomba lo revelamos
                board[box_index][:revealed?] = true
            end
        end
        assert_true(new_board.win())
    end
end
