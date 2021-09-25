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
        print "\n"
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
            print "\n"
        end
    end
end