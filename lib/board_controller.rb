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

  def request_input_coords
    response = @view.request_input_coords
    if request_input(response[0], response[1]) == 'Has introducido una jugada invalida'
      request_input_coords
    else
      request_input(response[0], response[1])
    end
  end

  def request_input(coord_x, coord_y)
    @view.request_play
    return @view.send_error_message if !coord_x.between?(1, @model.width) || !coord_y.between?(1, @model.width)

    [coord_x, coord_y]
  end

  def play
    @view.print_board(@model)
    if @model.game_over
      @view.game_over
    elsif @model.win
      @view.congratulate
    else
      input = request_input_coords
      @model.reveal(input[0], input[1])
      play
    end
  end
end
