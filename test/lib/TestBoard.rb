require 'minitest/autorun'
require 'set'

require '../../lib/battleships/Board'

class TestBoard < MiniTest::Unit::TestCase
  
  def setup
    @board = Board.new(3, 3)
  end
  
  def test_3_by_3
    assert_instance_of(Tile, @board.get('A0'))
    assert_instance_of(Tile, @board.get('C2'))
    assert_nil(@board.get('A3'))
    assert_nil(@board.get('D0'))
  end
  
  def test_single_tile_is_continguous
    assert(@board.contiguous?(['A1']))
  end
  
  def test_contiguous_row 
    assert(@board.contiguous?(['B0', 'B1']))
  end
  
  def test_contiguous_column
    assert(@board.contiguous?(['A2', 'B2', 'C2']))
  end
  
  def test_disparate_tiles
    refute(@board.contiguous?(['A0', 'C2']))
  end
  
end