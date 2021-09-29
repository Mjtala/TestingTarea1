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
    if x > @model.width || x <= 0 || y > @model.width || y <= 0 || response.length <= 1 || response.include?('\\n') || response.include?('0')
      @view.send_error_message
      return request_input
    end
    response
    ## aqui se obtiene la posicion que elige el jugador
  end

  def play
    @view.print_board(@model)
    # aqui tienen que hacer todo el flujo del juego // miren el juego del profe
    if @model.game_over
      @view.game_over
      nil
    elsif @model.win
      @view.congratulate
    else
      input = request_input
      @model.reveal(input[0], input[1])
      play
    end
  end
end
