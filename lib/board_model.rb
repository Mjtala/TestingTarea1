require 'matrix'

class Board
    attr_accessor :board, :width

    def initialize(size = 3, amount_mines = 3)
        @board = []
        @bomb = "💣"
        @empty = "▪︎"
        @exploded= "💥"
        @width = size.to_i
        @amount_mines = amount_mines.to_i
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

    def define_adyacent_bombs
        @board.length.times do |i|
            unless @board[i][:value] == @bomb
                @board[i][:value] = get_total_adyacent_bombs(i)
            end
        end 
    end
    
    def get_total_adyacent_bombs(position)
        row, col = get_coordinates(position)
        total_bombs = 0

        for values, index in @bordering.each_with_index
            neighbour = [row + values[0], col + values[1]]
            if neighbour.include?(0) || neighbour.include?(@width+1)
                # estamos afuera del tablero por lo que no tenemos que calcular nada
                next
            end
            # pasamos los valores de matríz a lista, neighbour[0] = x
            position_in_board = (neighbour[0]-1) * @width + (neighbour[1] - 1)
            if @board[position_in_board][:value] == @bomb
                total_bombs += 1
            end
        end
        return total_bombs
    end

    # PASAMOS A MATRIZ EL VALOR DE LA LISTA
    def get_coordinates(i)
        row = (i/@width) +1
        col = (i % @width) +1
        return [row,col]
    end

end

