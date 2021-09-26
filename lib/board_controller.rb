class BoardController
    def initialize(boardModel, boardView)
        @model = boardModel
        @view = boardView
    end

    def printBoard
        @view.printBoard(@model)
    end

    def requestInput
        @view.requestPlay()
        key = $stdin.gets.to_i
        ## aqui se obtiene la posicion que elige el jugador

    end

    def select(xo,yo)
        requestInput()
    end
end