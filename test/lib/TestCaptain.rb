require 'minitest/autorun'

require '../../lib/battleships/Captain'
require '../../lib/battleships/Board'

class TestCaptain < MiniTest::Unit::TestCase
  
  def setup
    @board = Board.new(4, 4)
    @captain = Captain.new @board
  end
  
  def test_distance_left_to_edge
    assert_equal(1, @captain.distance_to_previous_shot(0, 0, -1, 0))
    assert_equal(2, @captain.distance_to_previous_shot(1, 0, -1, 0))
  end
  
  def test_distance_right_to_edge
    assert_equal(4, @captain.distance_to_previous_shot(0, 2, 1, 0))
    assert_equal(3, @captain.distance_to_previous_shot(1, 2, 1, 0))
  end
  
  def test_distance_up_to_edge
    assert_equal(1, @captain.distance_to_previous_shot(1, 0, 0, -1))
    assert_equal(2, @captain.distance_to_previous_shot(1, 1, 0, -1))
  end
  
  def test_distance_down_to_edge
    assert_equal(4, @captain.distance_to_previous_shot(3, 0, 0, 1))
    assert_equal(3, @captain.distance_to_previous_shot(3, 1, 0, 1))
  end
  
  def test_distance_right_to_previous_shot
    assert_equal(4, @captain.distance_to_previous_shot(0, 0, 1, 0))
    @board.bombard('B0')
    assert_equal(1, @captain.distance_to_previous_shot(0, 0, 1, 0))
  end
  
  def test_determine_value
    @board.bombard 'A2'
    @board.bombard 'C0'
    @board.bombard 'D2'
    assert_equal(2.0, @captain.determine_value(0, 1))
    assert_equal(2.5, @captain.determine_value(1, 1))
  end
  
  def test_target_all_tiles
    (1..16).each do
      @board.bombard @captain.target
      #puts @board.status
    end
    
    (0..@board.width - 1).each do |x|
      (0..@board.height - 1).each do |y|
        assert(@board.get_coord(x, y).bombarded?)
      end
    end
  end
  
  def test_target_tile_in_line_with_previous_hits
    @board.get('B0').occupy
    @board.get('B1').occupy
    @board.get('B2').occupy
    @board.bombard 'B0'
    @captain.report_hit 'B0'
    @board.bombard 'B1'
    @captain.report_hit 'B1'
    assert_equal('B2', @captain.target)
  end

end