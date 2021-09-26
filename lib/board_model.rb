require 'matrix'

class Board
    attr_accessor :board, :width, :game_over

    def initialize(size = 3, amount_mines = 3)
        @board = []
        @bomb = "💣"
        @empty = "▪︎"
        @exploded= "💥"
        @width = size.to_i
        @amount_mines = amount_mines.to_i
        @game_over = false
        @bordering = [
            [-1,-1], #upper-left
            [-1,0], #top
            [-1,1], #upper-right
            [0,1], #right
            [1,1], #lower-right
            [1,0], #bottom
            [1,-1], #lower-left
            [0,-1] #left
        ]
        create_board()
        define_adyacent_bombs()
    end

    ## creamos el board, primero ponemos todas las bombas y después agregamos el resto de los elementos
    ## todos parten con revealed falso ya que el jugado no debe ver qué es lo que hay 
    ## usamos board shuffle para mezclar el tablero y que sean random las posiciones de las bombas
    def create_board()
        amount_total_squares = @width * @width
        for i in 1..amount_total_squares.to_i
            if (i <= @amount_mines) then
                @board.push({
                    value: @bomb,
                    revealed?: false, 
                })
            else
                @board.push({
                    value: @empty,
                    revealed?: false, 
                }) 
            end
        end 
        @board.shuffle!
        return @board
    end

    # buscamos todas las bombas adyacentes a un cuadrado y las contamos para poder poner 
    # el valor a los cuadrados. En el juego si apretas un cuadrado y sale 1 es porque tiene una
    # bomba adyacente. Eso es lo que hacemos acá. Le agremos hece valor
    def define_adyacent_bombs
        @board.length.times do |i|
            unless @board[i][:value] == @bomb
                @board[i][:value] = get_total_adyacent_bombs(i)
            end
        end 
    end

    # acá calculamos las bombas adyacentes revisando los 8 cuadrados con los que colinda
    # como trabajamos con una lista tenemos que estas constantemente cambiando los valores de
    # lista a matriz y de matriz a lista. Esto es lo que hacemos en la línea **
    # get coordinates hace lo contrario a la línea **, pasa de lista al valor coordenadas en la matriz
    def get_total_adyacent_bombs(position)
        row, col = get_coordinates(position)
        total_bombs = 0

        for values, index in @bordering.each_with_index
            neighbour = [row + values[0], col + values[1]]
            if neighbour.include?(0) || neighbour.include?(@width+1)
                # estamos afuera del tablero por lo que no tenemos que calcular nada
                next
            end
            # **  pasamos los valores de matríz a lista, neighbour[0] = x
            position_in_board = (neighbour[0]-1) * @width + (neighbour[1] - 1)
            if @board[position_in_board][:value] == @bomb
                total_bombs += 1
            end
        end
        return total_bombs
    end

    # Pasamos de lista a matriz
    def get_coordinates(i)
        row = (i/@width) +1
        col = (i % @width) +1
        return [row,col]
    end

end

