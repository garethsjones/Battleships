require_relative 'Ship'
require_relative 'Board'
require_relative 'Fleet'
require_relative 'TugBoat'

class SinglePlayerGame
  
  def main
    
    board = Board.new(10, 10)
    fleet = Fleet.new(board)
    tugBoat = TugBoat.new(fleet)
    
    tugBoat.auto_pilot 5, 4, 3, 3, 2
    
    shots = 0
    
    puts fleet.board().status
    puts fleet.summary
    
    while !fleet.all_sunk? do
      puts "Enter your firing coords:"
      coords = gets.strip
      puts fleet.shoot coords
      shots += 1
      
      puts fleet.board().status
      puts fleet.summary
      
      puts "You've had #{shots} shots"
      puts ''
    end
    
    puts "You sunk the entire fleet in #{shots} shots!!!"
    
  end
  
end