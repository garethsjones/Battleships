class Captain
  
  def initialize(board)
    @board = board
    @hits = []
  end
  
  def report_hit(tile_name)
    coords = @board.get_coords_from_name tile_name
    @hits.push coords
  end
  
  def report_sinkage
    @hits = []
  end
  
  def target
    if @hits.empty?
      return scan
    else
      return hunt
    end
  end
  
  def hunt
    hit1 = @hits[0];
    x1 = hit1[0];
    y1 = hit1[1]
    hitn = @hits[@hits.length - 1]; xn = hitn[0]; yn = hitn[1]
    
    targets = []
    if (x1 == xn)
      assess_target(x1, [y1, yn].min - 1, targets)
      assess_target(x1, [y1, yn].max + 1, targets)
    end
    if (y1 == yn)
      assess_target([x1, xn].min - 1, y1, targets)
      assess_target([x1, xn].max + 1, y1, targets)
    end
    
    if !targets.empty?
      return best_target targets
    end
    
    @hits.each do |hit|
      assess_target(hit[0] - 1, hit[1], targets)
      assess_target(hit[0] + 1, hit[1], targets)
      assess_target(hit[0], hit[1] - 1, targets)
      assess_target(hit[0], hit[1] + 1, targets)
    end
    
    if !targets.empty?
      return best_target targets
    end
    
    return scan
  end
  
  def assess_target(x, y, array)
    value = determine_value(x, y)
    if value > 0
      array.push Target.new(@board.get_coord(x, y).name, value)
    end
  end
  
  def scan
    targets = []
    
    (0..@board.width - 1).each do |x|
      (0..@board.height - 1).each do |y|
        tile_name = @board.get_coord(x, y).name
        value = determine_value(x, y)
        target = Target.new(tile_name, value)
        targets.push target
      end
    end
    
    return best_target targets
  end
  
  def determine_value(x, y)
    tile = @board.get_coord(x, y)
    
    distances = [distance_to_previous_shot(x, y, -1, 0),
    distance_to_previous_shot(x, y, 1, 0),
    distance_to_previous_shot(x, y, 0, -1),
    distance_to_previous_shot(x, y, 0, 1)]
    
    return distances.inject{ |sum, el| sum + el }.to_f / distances.size
  end
  
  def distance_to_previous_shot(x, y, delta_x, delta_y)
    distance = 0
    while true do
      
      search_x = x + (delta_x * distance)
      search_y = y + (delta_y * distance)
      
      if (search_x < 0 || search_x >= @board.width ||
        search_y < 0 || search_y >= @board.height)
        return distance
      end
      
      if @board.get_coord(search_x, search_y).bombarded?
        return distance
      end
      
      distance += 1
    end
  end
  
  def best_target(targets)
    targets.sort!
    best_value = targets[0].value
    targets.select! { |target|
      target.value == best_value
    }
    return targets[rand(0..targets.length - 1)].tile_name
  end
  
end

class Target
  
  def initialize(tile_name, value)
    @tile_name = tile_name
    @value = value
  end
  
  def tile_name; @tile_name; end
  def value; @value; end
  
  def <=> (other)
    other.value <=> @value
  end
end