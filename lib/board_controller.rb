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

    def select(x,y)
        # aqui tienen que hacer todo el flujo del juego // miren el juego del profe
        if @model.game_over then
            @view.game_over
        else
            requestInput()
        end
    end
end