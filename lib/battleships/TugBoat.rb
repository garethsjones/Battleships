require_relative 'Ship'

class TugBoat
  
  def initialize(fleet)
    @fleet = fleet
  end
  
  def manual_pilot(*ship_lengths)
    
    ship_lengths.sort!.reverse!
    board = @fleet.board
    
    ship_lengths.each do |ship_length|
      while true
        puts board.status(true)
        puts "Position ship of length #{ship_length}"
        positions = gets.strip.split
        
        if (positions.length != ship_length)
          puts "I asked for #{ship_length} coords but you gave me #{positions.length}"
          next
        end
        
        all_available = true
        positions.each do |position|
          if board.get position == nil
            puts "Position #{position} is not regocnised"
          end
          if (board.get(position).occupied?)
            puts "Position #{position} is already occupied."
            all_available = false
          end
        end
        
        if !all_available
          next
        end
        
        if !board.contiguous? positions
          puts "Those coords don't join up in a straight line. Try again."
          next
        end
        
        Ship.new(@fleet, *positions)
        break
        
      end
    end
    
  end
  
  def auto_pilot(*ship_lengths)
    
    ship_lengths.sort!.reverse!
    
    ship_lengths.each do |ship_length|
      if rand(0..1) == 0
        success = place_horizontally(ship_length) 
        if !success
          success = place_vertically(ship_length)
        end
      else
        success = place_vertically(ship_length)
        if !success
          success = place_horizontally(ship_length)
        end
      end
      
      if !success
        raise "Unable to place ship length #{ship_length} on board"
      end
    end
  end
  
  def place_horizontally(ship_length)
    
    board = @fleet.board()
    max_x = board.width() - ship_length
    
    available_start_coords = []
    
    (0..max_x).each do |x|
      (0..board.height() - 1).each do |y|
        
        available = true
        
        (0..ship_length - 1).each do |delta_x|
          tile = board.get_coord(x + delta_x, y)
          if tile.occupied?
            available = false
            break
          end
        end
        
        if (available)
          available_start_coords.push([x, y])
        end
        
      end
    end
    
    if (available_start_coords.empty?)
      return false
    end
    
    chosen_coords = available_start_coords[rand(0..available_start_coords.length - 1)]
    x = chosen_coords[0]
    y = chosen_coords[1]
    
    tile_names = Array.new
    (0..ship_length - 1).each do |delta_x|
      tile_names.push(board.get_coord(x + delta_x, y).name())
    end
    
    Ship.new(@fleet, *tile_names)
    
    return true
  end
  
  def place_vertically(ship_length)
        
    board = @fleet.board()
    max_y = board.height() - ship_length
    
    available_start_coords = []
    
    (0..max_y).each do |y|
      (0..board.width() - 1).each do |x|
        
        available = true
        
        (0..ship_length - 1).each do |delta_y|
          tile = board.get_coord(x, y + delta_y)
          if tile.occupied?
            available = false
            break
          end
        end
        
        if (available)
          available_start_coords.push([x, y])
        end
        
      end
    end
    
    if (available_start_coords.empty?)
      return false
    end
    
    chosen_coords = available_start_coords[rand(0..available_start_coords.length - 1)]
    x = chosen_coords[0]
    y = chosen_coords[1]
    
    tile_names = Array.new
    (0..ship_length - 1).each do |delta_y|
      tile_names.push(board.get_coord(x, y + delta_y).name())
    end
    
    Ship.new(@fleet, *tile_names)
    
    return true
  end
  
end