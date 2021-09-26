
class BoardView
    # def update(boarModel)
    #     clean()
    #     printBoard(boardModel)
    # end
    def printBoard(boardModel)
        print " "
        for i in  1..boardModel.width
            print " #{i}"
        end
        puts ""
        position = 0
        for i in 1..boardModel.width
            print i
            for j in 1..boardModel.width
                if (boardModel.board[position][:revealed?]) then
                    print boardModel.board[position][:value]
                else
                    print " ⬜"
                end
                position += 1
            end
            puts ""
        end
    end
    def startGame()
        puts()
        puts "Bienvenido a Minesweeper!"
        puts "Para jugar debes ingresar los números de la posición (fila, columna) con un espacio  que quieres descubrir."
        puts "Aquí está el tablero:"
    end
    def congratulate()
        puts "Felicitaciones has ganado!"
      end
    def gameOver()
        puts "Explotó una bomba! Haz perdido :("
    end

    def requestPlay()
        puts "Seleccióna tu jugada"
    end
end