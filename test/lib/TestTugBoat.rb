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
    @tugBoat.dock 2
    @tugBoat.dock 3
    puts @fleet.board().status(true)
    puts @fleet.status()
  end
  
end