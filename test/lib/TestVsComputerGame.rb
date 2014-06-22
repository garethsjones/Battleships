require 'minitest/autorun'

require '../../lib/battleships/VsComputerGame'

class TestVsComputerGame < MiniTest::Unit::TestCase
  
  def test
    game = VsComputerGame.new
    game.main
  end
  
end