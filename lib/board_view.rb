# frozen_string_literal: true

# Clase de la vista del tablero
class BoardView
  def print_board(board_model)
    print ' '
    (1..board_model.width).each do |i|
      print "    #{i}"
    end
    puts ''
    print_board_matrix(board_model)
    $stdout.flush
  end

  def print_board_matrix(board_model)
    position = 0
    (1..board_model.width).each do |i|
      print i
      (1..board_model.width).each do |_j|
        if board_model.board[position][:revealed?]
          print("    #{board_model.board[position][:value]}")
        else print '    ⬜'
        end
        position += 1
      end
      puts ''
    end
  end

  def start_game
    puts
    puts 'Bienvenido a Minesweeper!!'
    puts 'Para jugar debes ingresar los números de la posición fila,columna  que quieres descubrir.'
    puts 'Aquí está el tablero:'
  end

  def congratulate
    puts 'Felicitaciones has ganado!'
  end

  def game_over
    puts 'Explotó una bomba! Haz perdido :('
  end

  def request_play
    puts 'Seleccióna tu jugada'
  end

  def send_error_message
    puts 'Has introducido una jugada invalida'
  end
end
