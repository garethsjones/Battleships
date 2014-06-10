require 'minitest/autorun'
require 'set'

require '../../lib/battleships/Board'

class TestBoard < MiniTest::Unit::TestCase
  
  def setup
    @board = Board.new(3, 3)
    @tiles = Set.new
  end
  
  def xtest_status
    puts @board.status
  end
  
  def test_3_by_3
    assert_instance_of(Tile, @board.get('A0'))
    assert_instance_of(Tile, @board.get('C2'))
    assert_nil(@board.get('A3'))
    assert_nil(@board.get('D0'))
  end
  
  def test_single_tile_is_continguous
    tileA1 = @board.get('A1')
    @tiles.add tileA1
    
    assert(@board.contiguous?(@tiles))
  end
  
  def test_contiguous_row
    tileB0 = @board.get('B0')
    tileB1 = @board.get('B1')
    @tiles.add(tileB0)
    @tiles.add(tileB1)
    
    assert(@board.contiguous?(@tiles))
  end
  
  def test_contiguous_column
    tileA2 = @board.get('A2')
    tileB2 = @board.get('B2')
    tileC2 = @board.get('C2')
    @tiles.add(tileA2)
    @tiles.add(tileB2)
    @tiles.add(tileC2)
    
    assert(@board.contiguous?(@tiles))
  end
  
  def test_disparate_tiles
    tileA0 = @board.get('A0')
    tileC2 = @board.get('C2')
    
    @tiles.add(tileA0)
    @tiles.add(tileC2)
    
    refute(@board.contiguous?(@tiles))
  end
  
end