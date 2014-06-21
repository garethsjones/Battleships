require 'minitest/autorun'

require '../../lib/battleships/Tile'

class TestTile < MiniTest::Unit::TestCase
  
  def setup
    @tile = Tile.new('A0')
  end
  
  def test_must_initialize_as_unknown
    assert_equal(Tile::STATUS_UNKNOWN, @tile.status)
  end
  
  def test_must_show_as_unknown_when_occupied
    @tile.occupy
    assert_equal(Tile::STATUS_UNKNOWN, @tile.status)
  end
  
  def test_must_show_as_occupied_when_occupied_and_showing_hidden
    @tile.occupy
    assert_equal(Tile::STATUS_HIDDEN, @tile.status(true))
  end
  
  def test_must_show_as_missed_when_not_occupied_and_bombarded
    @tile.bombard
    assert_equal(Tile::STATUS_MISSED, @tile.status)
  end
  
  def test_must_show_as_hit_when_occupied_and_bombarded
    @tile.occupy
    @tile.bombard
    assert_equal(Tile::STATUS_HIT, @tile.status)
  end
  
  def test_must_raise_error_when_occupying_an_occupied_tile
    @tile.occupy

    begin  
      @tile.occupy
    rescue RuntimeError => e  
      assert_equal('Tile A0 is already occupied', e.message)
      return
    end
    
    flunk 'We really should have raised an error by now'
  end
  
end