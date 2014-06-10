require 'minitest/autorun'

require '../../lib/battleships/Tile'
require '../../lib/battleships/Ship'
require '../../lib/battleships/Board'
require '../../lib/battleships/Fleet'

class TestFleet < MiniTest::Unit::TestCase
  
  def setup
    @board = Board.new(5, 5)
    @fleet = Fleet.new(@board)
    
    @ship3 = Ship.new
    @fleet.add @ship3
    @ship3.moor 'B2'
    @ship3.moor 'B3'
    @ship3.moor 'B4'
    
    @ship2 = Ship.new
    @fleet.add @ship2
    @ship2.moor 'D1'
    @ship2.moor 'E1'
  end

  def test_afloat
    assert_equal(2, @fleet.afloat)
  end
  
  def test_sunk
    assert_equal(0, @fleet.sunk)
    @board.bombard 'D1'
    @board.bombard 'E1'
    assert_equal(1, @fleet.sunk)
    @board.bombard 'B2'
    @board.bombard 'B3'
    @board.bombard 'B4'
    assert_equal(2, @fleet.sunk)
  end
  
  def test_all_sunk
    refute @fleet.all_sunk?
    @board.bombard 'D1'
    @board.bombard 'E1'
    @board.bombard 'B2'
    @board.bombard 'B3'
    @board.bombard 'B4'
    assert @fleet.all_sunk?
  end
  
  def test_summary
    @board.bombard 'D1'
    @board.bombard 'E1'
    assert_equal('Afloat: 1 Sunk: 1', @fleet.summary)
  end
  
  def test_status
    @board.bombard 'D1'
    @board.bombard 'E1'
    @board.bombard 'B3'
    @board.bombard 'B4'
    assert_equal("Patrol Boat Damage: 2/2 Status: Sunk\nDestroyer Damage: 2/3 Status: Afloat\n", @fleet.status)
  end
end