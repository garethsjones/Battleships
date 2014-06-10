TILE_STATUS_HIT      = '#'
TILE_STATUS_HIDDEN   = 'O'
TILE_STATUS_MISSED   = '-'
TILE_STATUS_UNKNOWN  = ' '

class Tile
  
  def initialize(name)
    @name = name
    @is_occupied = false
    @is_bombarded = false
  end
  
  def bombard; @is_bombarded = true; end
  def occupied?; @ship != nil; end
  def bombarded?; @is_bombarded; end
  
  def occupy(ship)
    if occupied?
      raise "Tile #{@name} is already occupied by #{@ship.type}"
    end
    @ship = ship
  end
  
  def status(show_hidden = false)
    if occupied? && bombarded?
      TILE_STATUS_HIT
    elsif bombarded?
      TILE_STATUS_MISSED
    elsif occupied? && show_hidden
      TILE_STATUS_HIDDEN
    else
      TILE_STATUS_UNKNOWN
    end
  end
  
end