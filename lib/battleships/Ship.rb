require 'set'

SHIP_STATUS_AFLOAT  = 'Afloat'
SHIP_STATUS_SUNK    = 'Sunk'

class Ship
  
  def initialize(fleet, *tile_names)
    @fleet = fleet
    @tiles = Set.new
    
    if !@fleet.board().contiguous?(tile_names)
      raise "Tiles are not contiguous"
    end
    
    tile_names.each do |tile_name|
      moor tile_name
    end
    @fleet.add self
  end
  
  def status
    @tiles.each do |tile|
      if tile.status != TILE_STATUS_HIT
        return SHIP_STATUS_AFLOAT
      end
    end
    return SHIP_STATUS_SUNK
  end
  
  def damage
    fires = 0
    
    @tiles.each do |tile|
      if tile.status == TILE_STATUS_HIT
        fires += 1
      end
    end
    return fires
  end
  
  def moor(tile_name)
    tile = @fleet.board().get(tile_name)
    if tile == nil
      raise "#{tile_name} is not on the board"
    end
    
    @tiles.add tile
    tile.occupy
  end
  
  def length
    @tiles.length
  end
  
  def <=> other
    length <=> other.length
  end
  
  def type
    case length
    when 0
      'Dingy'
    when 1
      'Mine'
    when 2
      'Patrol Boat'
    when 3
      'Destroyer'
    when 4
      'Battleship'
    when 5
      'Aircraft Carrier'
    else
      'Cthulu'
    end
  end
end