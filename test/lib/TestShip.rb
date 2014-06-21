require 'minitest/autorun'

require '../../lib/battleships/Tile'
require '../../lib/battleships/Ship'
require '../../lib/battleships/Board'
require '../../lib/battleships/Fleet'

class TestShip < MiniTest::Unit::TestCase
  
  def setup
    @board = Board.new(3, 3)
    @fleet = Fleet.new(@board)
    @ship = Ship.new(@fleet, 'A0', 'A1')
  end
  
  def test_status_ship_with_no_hits
    assert_equal(Ship::STATUS_AFLOAT, @ship.status)
  end
  
  def test_status_ship_with_some_hits
    @board.bombard 'A0'
    assert_equal(Ship::STATUS_AFLOAT, @ship.status)
  end
  
  def test_status_ship_with_all_hits
    @board.bombard 'A0'
    @board.bombard 'A1'
    assert_equal(Ship::STATUS_SUNK, @ship.status)
  end
  
  def test_damage
    assert_equal(0, @ship.damage)
    @board.bombard 'A0'
    assert_equal(1, @ship.damage)
    @board.bombard 'A1'
    assert_equal(2, @ship.damage)
  end
  
  def test_already_occupied
    assert_raises RuntimeError do
      ship = Ship.new(@fleet, 'A0', 'B0')
    end
  end
  
  def test_already_occupied
    assert_raises RuntimeError do
      ship = Ship.new(@fleet, 'B0', 'C1')
    end
  end
  
  def test_is_moored_at
    assert @ship.is_moored_at 'A1'
    refute @ship.is_moored_at 'B1'
  end
  
end