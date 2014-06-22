require 'minitest/autorun'

require '../../lib/battleships/TugBoat'
require '../../lib/battleships/Fleet'
require '../../lib/battleships/Board'

class TestTugBoat < MiniTest::Unit::TestCase
  
  def setup
    @board = Board.new(5, 5)
    @fleet = Fleet.new(@board)
    @tugBoat = TugBoat.new(@fleet)
  end
  
  def test
    @tugBoat.auto_pilot 2, 3
    puts @fleet.board().status(true)
    puts @fleet.status()
  end
  
  def test_manual
    @tugBoat.manual_pilot 2, 3
  end
  
end