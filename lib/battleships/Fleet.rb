class Fleet
  
  def initialize(board)
    @board = board
    @ships = Array.new
  end
  
  def board; @board; end
  
  def add(ship)
    ship.join_fleet self
    @ships.push ship
    @ships.sort!
  end
  
  def afloat
    afloat = 0
    
    @ships.each do |ship|
      if ship.status == SHIP_STATUS_AFLOAT
        afloat += 1
      end
    end
    
    return afloat
  end
  
  def sunk
    sunk = 0
    
    @ships.each do |ship|
      if ship.status == SHIP_STATUS_SUNK
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
      status += "#{ship.type} Damage: #{ship.damage}/#{ship.length} Status: #{ship.status}\n"
    end
    
    return status
  end
  
  def all_sunk?
    return size() == sunk()
  end
  
end