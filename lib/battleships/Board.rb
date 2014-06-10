require_relative 'Border'
require_relative 'Tile'

class Board
  
  def initialize(width = 10, height = 10)
    @width = width
    @height = height
    initialize_board
  end
  
  def initialize_board
    
    @board = Array.new(@width + 2)
    @tiles = Hash.new
    
    for x in 0..@width + 1
      
      @board[x] = Array.new(@height + 2)
      
      for y in 0..@height + 1
        
        x_name = (64 + x).chr
        
        if ((x == 0 || x == @width + 1) && (y == 0 || y == @height + 1))
          @board[x][y] = Border.new(' ')
        elsif (x == 0 || x == @width + 1)
          @board[x][y] = Border.new((y - 1).to_s)
        elsif (y == 0 || y == @height + 1)
          @board[x][y] = Border.new(x_name)
        else
          tile_name = x_name + (y - 1).to_s
          @board[x][y] = Tile.new(tile_name)
          @tiles[tile_name] = @board[x][y]
        end
        
      end
    end
  end
  
  def status(show_hidden = false) 
    status = ''
    
    for x in 0..@width + 1
      for y in 0..@height + 1
        status += @board[x][y].status(show_hidden)       
      end
      status += "\n"
    end
    
    return status
  end
  
  def contiguous?(tiles)
    for x in 0..@width + 1
      for y in 0..@height + 1
        if tiles.include? @board[x][y]
          return (row_occupied(x, y, tiles) || column_occupied(x, y, tiles))
        end     
      end
    end
    return false
  end
  
  def row_occupied(x, y, tiles)
    for y_delta in 0..tiles.size - 1
      if !tiles.include? @board[x][y + y_delta]
        return false
      end
    end
    return true
  end
  
  def column_occupied(x, y, tiles)
    for x_delta in 0..tiles.size - 1
      if !tiles.include? @board[x + x_delta][y]
        return false
      end
    end
    return true
  end
  
  def get(tile_name)
    return @tiles[tile_name]
  end
  
  def bombard(tile_name)
    get(tile_name).bombard
  end
  
end