# frozen_string_literal: true

# Clase del controlador del tablero del juego
class BoardController
  def initialize(board_model, board_view)
    @model = board_model
    @view = board_view
  end

  def print_board
    @view.print_board(@model)
  end

  def request_input
    @view.request_play
    key = $stdin.gets
    x = key.split(',')[0].to_i
    y = key.split(',')[1].to_i
    response = [x, y]
    if !x.between?(1, @model.width) && !y.between?(1, @model.width)
      @view.send_error_message
      return request_input
    end
    response
  end

  def play
    @view.print_board(@model)
    if @model.game_over
      @view.game_over
    elsif @model.win
      @view.congratulate
    else
      input = request_input
      @model.reveal(input[0], input[1])
      play
    end
  end
end
