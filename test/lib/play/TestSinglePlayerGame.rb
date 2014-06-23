require 'minitest/autorun'

require '../../../lib/battleships/play/SinglePlayerGame'

class TestSinglePlayerGame < MiniTest::Unit::TestCase
  
  def test
    game = SinglePlayerGame.new
    game.main
  end
  
end