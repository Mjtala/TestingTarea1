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
        create_board()
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

    # def define_adyacent_bombs

    # end
end

