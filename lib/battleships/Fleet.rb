class Fleet
  
  SHOT_RESULT_MISS = 'Miss'
  SHOT_RESULT_HIT = 'Hit!'
  SHOT_RESULT_SINK = 'You sunk my battleship!!'
  
  def initialize(board)
    @board = board
    @ships = Array.new
  end
  
  def board; @board; end
  
  def add(ship)
    @ships.push ship
    @ships.sort!
  end
  
  def afloat
    afloat = 0
    
    @ships.each do |ship|
      if ship.status == Ship::STATUS_AFLOAT
        afloat += 1
      end
    end
    
    return afloat
  end
  
  def sunk
    sunk = 0
    
    @ships.each do |ship|
      if ship.status == Ship::STATUS_SUNK
        sunk += 1
      end
    end
    
    return sunk
  end
  
  def size
    @ships.length
  end
  
  def summary
    "Afloat: #{afloat} Sunk: #{sunk}"
  end
  
  def status
    status = ''
    
    @ships.each do |ship|
      status += "#{'%-16.16s' % ship.type} Damage: #{ship.damage}/#{ship.length} Status: #{ship.status}\n"
    end
    
    return status
  end
  
  def all_sunk?
    return size() == sunk()
  end
  
  def shoot(tile_name)
    
    tile = @board.get(tile_name)
    
    if tile == nil
      return SHOT_RESULT_MISS
    end
    
    @board.bombard tile_name
    
    if !tile.occupied?
      return SHOT_RESULT_MISS
    end
    
    @ships.each do |ship|
      if ship.is_moored_at tile_name
        if ship.status == Ship::STATUS_AFLOAT
          return SHOT_RESULT_HIT
        else
          return SHOT_RESULT_SINK
        end
      end
    end
  end
  
end