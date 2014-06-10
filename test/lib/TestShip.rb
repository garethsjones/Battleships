require 'minitest/autorun'

require '../../lib/battleships/Tile'
require '../../lib/battleships/Ship'
require '../../lib/battleships/Board'
require '../../lib/battleships/Fleet'

class TestShip < MiniTest::Unit::TestCase
  
  def setup
    @board = Board.new(3, 3)
    @fleet = Fleet.new(@board)
    @ship = Ship.new
    @fleet.add @ship
    @ship.moor 'A0'
    @ship.moor 'A1'
  end
  
  def test_status_ship_with_no_moorings
    ship = Ship.new
    assert_equal(SHIP_STATUS_SUNK, ship.status)
  end
  
  def test_status_ship_with_no_hits
    assert_equal(SHIP_STATUS_AFLOAT, @ship.status)
  end
  
  def test_status_ship_with_some_hits
    @board.bombard 'A0'
    assert_equal(SHIP_STATUS_AFLOAT, @ship.status)
  end
  
  def test_status_ship_with_all_hits
    @board.bombard 'A0'
    @board.bombard 'A1'
    assert_equal(SHIP_STATUS_SUNK, @ship.status)
  end
  
  def test_damage
    assert_equal(0, @ship.damage)
    @board.bombard 'A0'
    assert_equal(1, @ship.damage)
    @board.bombard 'A1'
    assert_equal(2, @ship.damage)
  end
  
end