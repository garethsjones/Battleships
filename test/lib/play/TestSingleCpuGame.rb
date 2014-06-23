require 'minitest/autorun'

require '../../../lib/battleships/play/SingleCpuGame'

class TestSinglePlayerGame < MiniTest::Unit::TestCase
  
  def test
    game = SingleCpuGame.new
    game.main
  end
  
end