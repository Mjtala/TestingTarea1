# frozen_string_literal: true

require_relative './board_model'
require_relative './board_controller'
require_relative './board_view'

model = Board.new(5, 2)
view = BoardView.new
controller = BoardController.new(model, view)
view.start_game
controller.play
