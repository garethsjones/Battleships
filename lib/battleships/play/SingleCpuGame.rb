require_relative '../Ship'
require_relative '../Board'
require_relative '../Fleet'
require_relative '../TugBoat'
require_relative '../Captain'

class SingleCpuGame
  
  def main
    
    board = Board.new(10, 10)
    fleet = Fleet.new(board)
    tugBoat = TugBoat.new(fleet)
    captain = Captain.new(board)
    
    tugBoat.auto_pilot 5, 4, 3, 3, 2
    
    shots = 0
    
    puts fleet.board().status(true)
    puts fleet.status
    
    while !fleet.all_sunk? do
      coords = captain.target
      puts "CPU Coords: #{coords}"
      result = fleet.shoot coords
      puts result
      
      if result == Fleet::SHOT_RESULT_HIT
        captain.report_hit coords
      elsif result == Fleet::SHOT_RESULT_SINK
        captain.report_sinkage
      end
      shots += 1
      
      puts fleet.board().status(true)
      puts fleet.status
      
      puts "The CPU has had #{shots} shots"
      puts ''
      sleep(0.5)
    end
    
    puts "The CPU sunk the entire fleet in #{shots} shots!!!"
    
  end
  
end