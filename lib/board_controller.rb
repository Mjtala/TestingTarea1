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
    if request_input(response[0], response[1]) === 'Has introducido una jugada invalida'
      request_input_coords
    else
      return request_input(response[0], response[1])
    end
  end
  
  def request_input(x, y)
    @view.request_play
    if !x.between?(1, @model.width) || !y.between?(1, @model.width)
      return @view.send_error_message
    end
    return [x,y]
  end
  
  # def request_input
  #   @view.request_play
  #   response = @view.request_input_coords
  #   x = response[0]
  #   y = response[1]
  #   if !x.between?(1, @model.width) || !y.between?(1, @model.width)
  #     @view.send_error_message
  #     return request_input
  #   end
  #   response
  # end

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
