class BoardController
    def initialize(boardModel, boardView)
        @model = boardModel
        @view = boardView
    end

    def printBoard
        @view.printBoard(@model)
    end

    def requestInput()
        @view.requestPlay()
        key = $stdin.gets
        x = key.split(",")[0].to_i
        y = key.split(",")[1].to_i
        response = [x, y]
        if x > @model.width || x < 0 || y > @model.width || y < 0 || response.length <= 1
            @view.sendErrorMessage()
            requestInput()
        end
        return response
        ## aqui se obtiene la posicion que elige el jugador
    end

    def play
        @view.printBoard(@model)
        # aqui tienen que hacer todo el flujo del juego // miren el juego del profe
        if @model.game_over then
            @view.gameOver()
            return
        elsif @model.win()
            @view.congratulate()      
        else
            input = requestInput()
            @model.reveal(input[0], input[1])
            play()
        end
    end
end