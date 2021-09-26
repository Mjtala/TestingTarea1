require_relative './board_model'
require_relative './board_controller'
require_relative './board_view'

model = Board.new()
view = BoardView.new()
controller = BoardController.new(model, view)
view.startGame
controller.printBoard
controller.requestInput