require 'set'

class Ship
  
  STATUS_AFLOAT  = 'Afloat'
  STATUS_SUNK    = 'Sunk'
  
  def initialize(fleet, *tile_names)
    @tiles = Set.new
    @fleet = fleet
    
    if !@fleet.board().contiguous?(tile_names)
      raise "Tiles are not contiguous"
    end
    
    tile_names.each do |tile_name|
      if @fleet.board().get(tile_name).occupied?
        raise "Tile #{tile_name} is already occupied"
      end
    end
    
    tile_names.each do |tile_name|
      moor tile_name
    end
    
    @fleet.add self
  end
  
  def status
    @tiles.each do |tile|
      if tile.status != Tile::STATUS_HIT
        return STATUS_AFLOAT
      end
    end
    return STATUS_SUNK
  end
  
  def damage
    fires = 0
    
    @tiles.each do |tile|
      if tile.status == Tile::STATUS_HIT
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
  
  def is_moored_at(tile_name)
    @tiles.each do |tile|
      if tile.name == tile_name
        return true
      end
    end
    return false
  end
  
  def length
    @tiles.length
  end
  
  def <=> other
    other.length <=> length
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