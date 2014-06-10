require 'minitest/autorun'

require '../../lib/battleships/Tile'
require '../../lib/battleships/Ship'

class TestTile < MiniTest::Unit::TestCase
  
  def setup
    @ship = Ship.new()
    @tile = Tile.new('A0')
  end
  
  def test_must_initialize_as_unknown
    assert_equal(TILE_STATUS_UNKNOWN, @tile.status)
  end
  
  def test_must_show_as_unknown_when_occupied
    @tile.occupy @ship
    assert_equal(TILE_STATUS_UNKNOWN, @tile.status)
  end
  
  def test_must_show_as_occupied_when_occupied_and_showing_hidden
    @tile.occupy @ship
    assert_equal(TILE_STATUS_HIDDEN, @tile.status(true))
  end
  
  def test_must_show_as_missed_when_not_occupied_and_bombarded
    @tile.bombard
    assert_equal(TILE_STATUS_MISSED, @tile.status)
  end
  
  def test_must_show_as_hit_when_occupied_and_bombarded
    @tile.occupy @ship
    @tile.bombard
    assert_equal(TILE_STATUS_HIT, @tile.status)
  end
  
  def test_must_raise_error_when_occupying_an_occupied_tile
    @tile.occupy @ship

    begin  
      @tile.occupy @ship
    rescue RuntimeError => e  
      assert_equal('Tile A0 is already occupied by Dingy', e.message)
      return
    end
    
    flunk 'We really should have raised an error by now'
  end
  
end