# frozen_string_literal: true

class BoardView
  # def update(boarModel)
  #     clean()
  #     printBoard(boardModel)
  # end
  def printBoard(boardModel)
    print ' '
    (1..boardModel.width).each do |i|
      print "     #{i}"
    end
    puts ''
    position = 0
    (1..boardModel.width).each do |i|
      print i
      (1..boardModel.width).each do |_j|
        if boardModel.board[position][:revealed?]
          print("    #{boardModel.board[position][:value]}")
        else
          print '    ⬜'
        end
        position += 1
      end
      puts ''
    end
    STDOUT.flush
  end

  def startGame
    puts
    puts 'Bienvenido a Minesweeper!'
    puts 'Para jugar debes ingresar los números de la posición (fila, columna) con un espacio  que quieres descubrir.'
    puts 'Aquí está el tablero:'
  end

  def congratulate
    puts 'Felicitaciones has ganado!'
  end

  def gameOver
    puts 'Explotó una bomba! Haz perdido :('
  end

  def requestPlay
    puts 'Seleccióna tu jugada'
  end

  def sendErrorMessage
    puts 'Has introducido una jugada invalida'
  end
end
