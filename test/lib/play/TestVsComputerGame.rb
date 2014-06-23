require 'minitest/autorun'

require '../../../lib/battleships/play/VsCpuGame'

class TestVsCpuGame < MiniTest::Unit::TestCase
  
  def test
    game = VsCpuGame.new
    game.main
  end
  
end