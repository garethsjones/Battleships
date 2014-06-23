require_relative '../Ship'
require_relative '../Board'
require_relative '../Fleet'
require_relative '../TugBoat'
require_relative '../Captain'

class VsCpuGame
  
  def main
    
    myBoard = Board.new(10, 10)
    myFleet = Fleet.new(myBoard)
    myTugBoat = TugBoat.new(myFleet)
    
    myTugBoat.auto_pilot 5, 4, 3, 3, 2
    
    while true
      puts "Your board:"
      puts myFleet.board().status(true)
      puts myFleet.summary
      puts "SHUFFLE to randomise / MANUAL to place ships yourself / OK to start..."
      action = gets.strip
      
      case action
      when 'OK'
        break
      when 'SHUFFLE'
        myBoard = Board.new(10, 10)
        myFleet = Fleet.new(myBoard)
        myTugBoat = TugBoat.new(myFleet)
        myTugBoat.auto_pilot 5, 4, 3, 3, 2
      when 'MANUAL'
        myBoard = Board.new(10, 10)
        myFleet = Fleet.new(myBoard)
        myTugBoat = TugBoat.new(myFleet)
        myTugBoat.manual_pilot 5, 4, 3, 3, 2
      else
        puts "I don't know how to #{action}"
      end
    end
    
    puts ''
    
    theirBoard = Board.new(10, 10)
    theirFleet = Fleet.new(theirBoard)
    theirTugBoat = TugBoat.new(theirFleet)
    theirCaptain = Captain.new(myBoard)
    
    theirTugBoat.auto_pilot 5, 4, 3, 3, 2
    
    puts "Their board:"
    puts theirFleet.board().status
    puts theirFleet.summary
    
    puts ''
    
    while !(myFleet.all_sunk? || theirFleet.all_sunk?) do
      puts "Enter your firing coords:"
      myCoords = gets.strip
      
      if (myCoords == 'CHEAT')
        puts theirFleet.board().status(true)
        puts theirFleet.status
      else
        puts theirFleet.shoot myCoords
        puts theirFleet.board().status
        puts theirFleet.summary
      end
      
      puts ''
      
      theirCoords = theirCaptain.target
      puts "Their coords: #{theirCoords}"
      theirResult = myFleet.shoot theirCoords
      puts theirResult
      
      if theirResult == Fleet::SHOT_RESULT_HIT
        theirCaptain.report_hit theirCoords
      elsif theirResult == Fleet::SHOT_RESULT_SINK
        theirCaptain.report_sinkage
      end
      
      puts myFleet.board().status(true)
      puts myFleet.status
      
      puts ''
    end
    
    if myFleet.all_sunk? && theirFleet.all_sunk?
      puts "An honourable draw but you're both dead! :("
    elsif myFleet.all_sunk?
      puts "You lose. Better luck next time Admiral!"
    else
      puts "This glorious victory will live forever in history!"
    end
    
    puts "Your final board:"
    puts myFleet.board().status(true)
    puts myFleet.status
    
    puts "Their final board:"
    puts theirFleet.board().status(true)
    puts theirFleet.status
    
  end
  
end