class Tile
  
  STATUS_HIT      = '#'
  STATUS_HIDDEN   = 'O'
  STATUS_MISSED   = '-'
  STATUS_UNKNOWN  = ' '
  
  def initialize(name)
    @name = name
    @is_occupied = false
    @is_bombarded = false
  end
  
  def name; @name; end
  def bombard; @is_bombarded = true; end
  def occupied?; @is_occupied; end
  def bombarded?; @is_bombarded; end
  
  def occupy
    if occupied?
      raise "Tile #{@name} is already occupied"
    end
    @is_occupied = true
  end
  
  def status(show_hidden = false)
    if occupied? && bombarded?
      STATUS_HIT
    elsif bombarded?
      STATUS_MISSED
    elsif occupied? && show_hidden
      STATUS_HIDDEN
    else
      STATUS_UNKNOWN
    end
  end
  
end