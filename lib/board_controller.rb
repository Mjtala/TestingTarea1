class BoardController
    def initialize(boardModel, boardView)
        @model = boardModel
        @view = boardView
    end

    def printBoard
        @view.printBoard(@model)
    end
end