# frozen_string_literal: true

require 'matrix'

# Clase del tablero del juego (modelo)
class Board
  attr_accessor :board, :width, :game_over

  def initialize(size = 5, amount_mines = 3)
    @board = []
    @checked = []
    @width = size.to_i
    @amount_mines = amount_mines.to_i
    @game_over = false
    @bordering = [[-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1]]
    @bordering_cross = [[-1, 0], [0, 1], [1, 0], [0, -1]]
    initialize_objects
  end

  def initialize_objects
    @bomb = '💣'
    @empty = '▪︎'
    @exploded = '💥'
    create_board
    define_adyacent_bombs
  end

  ## creamos el board, primero ponemos todas las bombas y despues agregamos el resto de los elementos
  ## todos parten con revealed falso ya que el jugado no debe ver que es lo que hay
  ## usamos board shuffle para mezclar el tablero y que sean random las posiciones de las bombas
  def create_board
    (1..(@width * @width).to_i).each do |i|
      values = i <= @amount_mines ? @bomb : @empty
      @board.push({
                    value: values,
                    revealed?: false
                  })
    end
    @board.shuffle!
    @board
  end

  # buscamos todas las bombas adyacentes a un cuadrado y las contamos para poder poner
  # el valor a los cuadrados. En el juego si apretas un cuadrado y sale 1 es porque tiene una
  # bomba adyacente. Eso es lo que hacemos aca. Le agremos hece valor
  def define_adyacent_bombs
    @board.length.times do |i|
      @board[i][:value] = get_total_adyacent_bombs(i) unless @board[i][:value] == @bomb
    end
  end

  # aca calculamos las bombas adyacentes revisando los 8 cuadrados con los que colinda
  # como trabajamos con una lista tenemos que estas constantemente cambiando los valores de
  # lista a matriz y de matriz a lista. Esto es lo que hacemos en la linea **
  # get coordinates hace lo contrario a la linea **, pasa de lista al valor coordenadas en la matriz
  def if_bomb(row, col, values)
    neighbour = [row + values[0], col + values[1]]
    position_in_board = get_position_in_board(neighbour[0], neighbour[1])
    return unless @board[position_in_board]
    return true if @board[position_in_board][:value] == @bomb
  end

  def get_total_adyacent_bombs(position)
    row, col = get_coordinates(position)
    total_bombs = 0
    @bordering.each_with_index.each do |values|
      total_bombs += 1 if if_bomb(row, col, values)
    end
    total_bombs
  end

  # Pasamos de lista a matriz
  def get_coordinates(pos)
    row = (pos / @width) + 1
    col = (pos % @width) + 1
    [row, col]
  end

  def get_position_in_board(row, col)
    (row - 1) * @width + (col - 1)
  end

  def check_contditions(row, col, values)
    neighbour, p = assign(row, col, values)
    if !neighbour[0].between?(0, @width) || !neighbour[1].between?(0, @width) || @board[p][:value] == @bomb ||
       @checked.include?([neighbour[0], neighbour[1]]) || neighbour.include?(0) || neighbour.include?(@width + 1)
      true
    end
  end

  def assign(row, col, values)
    neighbour = [row + values[0], col + values[1]]
    p = get_position_in_board(neighbour[0], neighbour[1])
    [neighbour, p]
  end

  def check(neighbour)
    @checked.push([neighbour[0], neighbour[1]])
  end

  def check_boundaries(row, col, values)
    neighbour, p = assign(row, col, values)
    if check_contditions(row, col, values) then check(neighbour)
    elsif @board[p][:value] != 0 then @board[p][:revealed?] = true
                                      check(neighbour)
    else
      check(neighbour)
      reveal(neighbour[0], neighbour[1])
    end
  end

  #  def check_already_revealed(ind)
  #    if @board[ind][:revealed?]
  #      1
  #    else
  #      @board[ind][:revealed?] = true
  #      0
  #    end
  #  end

  def reveal(row, col)
    i = get_position_in_board(row, col)
    @board[i][:revealed?] = true
    if @board[i][:value] == @bomb then @game_over = true
                                       nil
    elsif (@board[i][:value]).zero? then @checked.push([row, col])
                                         @bordering.each_with_index.each do |values|
                                           check_boundaries(row, col, values)
                                         end
    end
  end

  def win
    count_revealed = 0
    @board.each do |element|
      count_revealed += 1 if element[:revealed?]
    end
    @board.length - count_revealed == @amount_mines
  end
end
